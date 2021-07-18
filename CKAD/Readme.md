# setup kubernetes cluster by minikube 

## install minikube 
on Windows can install **minikube** via ```choco install minikube -y```
on Ubuntu can install via ```sudo snap install minikube -y```

## use minikube setup k8s cluster on Windows
There 3 options for windows 
* use VirtualBox as hypervisor to run k8s cluster in a virtual PC
* use Hyper-V as hypervisor to run k8s cluster in a virtual PC
* run over Docker for Windows 

to use ``` minikube config set drver {virtualbox|hyperv|docker}```

after setup cluster (if update to new version) , then need to run **```minikube kubectl```** to pull new kubectl 

## use minikube setup k8s cluster on Linux 
CentOS / Ubuntu 
TBD

## get cluster config