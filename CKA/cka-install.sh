#!/bin/bash

# Pull image in background
kubeadm config images pull --kubernetes-version 1.22.1 >>/tmp/master-upgrade.log 2>&1 &

# Install master dependencies
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/ap
t/sources.list.d/kubernetes.list
apt-get update -y >>/tmp/master-upgrade.log 2>&1
apt-get install -y kubectl=1.22.1-00 kubeadm=1.22.1-00 kubelet=1.22.1-00 >>/tmp/master-upgrade.log 2>&1

# Install node dependencies
ssh node01 'apt-get update -y &&  apt-get install -y kubelet=1.20.0-00 kubeadm=1.20.0-00' >/tmp/node-upgrade.log 2>&1 &

# Install K8s
kubeadm init --kubernetes-version=1.22.1 --pod-network-cidr=192.168.0.0/16 >>/tmp/master-upgrade.log 2>&1

## Copy config
mkdir -p $HOME/.kube >>/tmp/master-upgrade.log 2>&1
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config >>/tmp/master-upgrade.log 2>&1
sudo chown $(id -u):$(id -g) $HOME/.kube/config >>/tmp/master-upgrade.log 2>&1

# join the node
NODE_JOIN_CMD=$(kubeadm token create --print-join-command)
NODE_JOIN_CMD_FULL="kubeadm reset -f;  ${NODE_JOIN_CMD} --ignore-preflight-errors=all"
ssh -tt node01 "${NODE_JOIN_CMD_FULL}"  >>/tmp/node-upgrade.log 2>&1 &

# Install CNI
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml >>/tmp/master-upgrade.log 2>&1

touch /root/.kube/installed