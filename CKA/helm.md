# what's helm 
The package manager for Kubernetes. At Jan/2023 the release helm is 3.11
[helm](https://helm.sh/)

For Helm, there are **three important concepts**:
1. The *chart* is a bundle of information necessary to create an instance of a Kubernetes application.
1. The *config* contains configuration information that can be merged into a packaged chart to create a releasable object.
1. A *release* is a running instance of a chart, combined with a specific config.

# install helm

on Linux install 
```bash
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

on Windows install by choco
```
choco install kubernetes-helm
```


# install from helm repo