# New CKAD Curriculum

Available at Q3/2021

# Setup Cluster

[follow test to build cluster](setup-cluster.md)

## Application Design and Build

### Define, build and modify container images


### Understand Jobs and CronJobs
DOC:
[Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/)

### Understand multi-container Pod design
(Include sidecar, init and others)

### Utlize Presistent and ephemeral volumes
DOC:
[presistent volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
[ephemeral volumes](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/)

Concept:
**Some application need additional storage but don't care whether that data is stored persistently across restarts.**
Types of ephemeral volumes:

| Type | Describe |
| ---| -- |
| emptyDir | empty at Pod startup, with storage coming locally from the kubelet base directory (usually the root disk) or RAM |
| configMap, downloadAPI, secret | inject different kinds of Kubernetes data into a Pod |
| CSI  ephemeral volumes | similar to the previous volume kinds, but provided by special CSI drivers which specifically support this feature |
| generic  ephemeral volumes | which can be provided by all storage drivers that also support persistent volumes | 

