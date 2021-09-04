# use kubernetes playground 
That's a easy access via internet , run in browser . 
```
## init pod

## add network 
kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml

## add metric

### verify metric 
node1 ~]$  kubectl get apiservices |egrep metrics
v1beta1.metrics.k8s.io                 kube-system/metrics-server   False (MissingEndpoints)   2m33s


```

# use minikube 



# use kubeadm

```
## examples kubeadm init
## examples kubeadm add pods
kubeadm join 172.18.42.31:6443 --token 2qpeuw.3h0rr4ts66zd7z19 \
        --discovery-token-ca-cert-hash sha256:b46693f8eb7973f4ad0ddf404a29b7bc244c05fdd6dfff2b923bf71ea3697233

## verify config
You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
```
## kubeadm + cri

## kubeadm + docker

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## kubeadm + podman

# add network support 

[k8s doc network addons](https://kubernetes.io/docs/concepts/cluster-administration/addons/)

## use flannel

```
sudo -E kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

```

## use Calico

``` 
## install Calico operator
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml

## install Calico customer 
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml

watch kubectl get pods -n calico-system
```
