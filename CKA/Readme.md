# Version 
At Jan/2023 the CKA exam base on 1.26
[Kubernetes 1.26 release notes](https://kubernetes.io/blog/2022/12/09/kubernetes-v1-26-release/)

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

# use MicroK8s 

$ sudo snap install microk8s --classic
Add Nodes:
Enable addon


# use minikube 


# use kind 

## install kind

## use kind build cluster

## load image into cluster
> By default the cluster name is "kind" , if you choose other name or build many cluster , need to use ```--name tiny``` to indicate which cluster you want to load image 

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

The Docker official support has been stoar to 2021/Dec -- [Detail](https://kubernetes.io/blog/2020/12/02/dont-panic-kubernetes-and-docker/)
It's not simple , for new create cluster may simple to user cri as default container engine but for old (already run in production) ex: VMware has 
TKGI which is actually run ubuntu 1604 + docker on ESXi


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
