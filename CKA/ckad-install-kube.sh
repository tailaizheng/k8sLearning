curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
# Install selected version (here 1.22.1-00)
sudo apt-get update
sudo apt-get install -y kubectl=1.22.1-00 kubeadm=1.22.1-00 kubelet=1.22.1-00

sudo apt-mark hold kubelet kubeadm kubectl

# Turn off Swap 
sudo sed -i '/ swap / s/^/#/' /etc/fstab
# Make swapfile a comment
sudo swapoff -a

sudo kubeadm init

# Ip tables
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system