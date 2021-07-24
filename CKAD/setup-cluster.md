# CKAD


CKAD  Clusters

| Cluster | Members | CNI | Description |
|-----|-----|-----|-----|
| k8s |1 master, 2 worker | flannel |k8s cluster |
| dk8s |1 master, 1 worker | flannel | k8s cluster |
| nk8s |1 master, 2 worker | calico | k8s cluster |
| sk8s |1 master, 1 worker | flannel | k8s cluster |

# CKA



CKA Clusters

| Cluster | Members | CNI | Description |
|--- |--- | ---- | ----|
| k8s | 1 master, 2 worker |flannel |k8s cluster |
| hk8s |1 master, 2 worker | calico | k8s cluster |
| bk8s | 1 master, 1 worker | flannel |k8s cluster |
| wk8s | 1 master, 2 worker |flannel |k8s cluster |
| ek8s | 1 master, 2 worker |flannel | k8s cluster |
| ik8s |1 master, 1 base node |loopback |k8s cluster − missing worker node |

# script to build cluster

## k8s
```bash
#### use kubeadm init 
kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16

### add network flannel support
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

### add other two work node 
kubeadm join 192.168.0.33:6443 --token t80ie3.ibdoev79ctzaeokx \
    --discovery-token-ca-cert-hash sha256:6ca45a097447b8d1d48a66ed90bd8fb533a822dad1307d9e3502041649d07a48


### verify on master node
kubectl get nodes --watch 

### verify by get pods
[node1 ~]$ kubectl get pods -A
NAMESPACE     NAME                            READY   STATUS    RESTARTS   AGE
kube-system   coredns-74ff55c5b-8mbbs         0/1     Running   0          11m
kube-system   coredns-74ff55c5b-9m45s         0/1     Running   0          11m
kube-system   etcd-node1                      1/1     Running   1          10m
kube-system   kube-apiserver-node1            1/1     Running   1          11m
kube-system   kube-controller-manager-node1   1/1     Running   2          11m
kube-system   kube-flannel-ds-djsnm           1/1     Running   0          10m
kube-system   kube-flannel-ds-kbst9           1/1     Running   0          10m
kube-system   kube-flannel-ds-xvzf7           1/1     Running   0          9m50s
kube-system   kube-proxy-bdspw                1/1     Running   0          11m
kube-system   kube-proxy-sbb4z                1/1     Running   0          11m
kube-system   kube-proxy-xgwsn                1/1     Running   0          9m50s
kube-system   kube-scheduler-node1            1/1     Running   2          11m

```
## dk8s 

## nk8s/nk8s


## sk8s

