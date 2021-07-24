
# kubelet daemon
[kubelet doc](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)
* kubelet run on each node 
* Default tcp port 10250 , can change by --port 20250
* kubelet talk to Contral Plan : Kubernetes API 
* do : Check each container running and health status
* do : report Node status to k8s
* handles container's log
* cni , network 

`systemctl status kubelet`
`systemctl enable --now kubelet`

Shows current node status, such as tasks, memory, cpu and cgroups

`journalctl -u kubelet`
Shows log of error for current hostname

# kubectl cli 
kubectl use `.kube\config` to find current kubenetes cluster to work . 

`kubectl get pods -n $Name`
List pods in current namespace

`kubectl describe pods`


