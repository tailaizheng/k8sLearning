
# Docker Swarm Concept

## Network Communication
* TCP port 2377 for cluster management communications
* TCP and UDP port 7946 for communication among nodes
* UDP port 4789 for overlay network traffic
*  ip protocol 50 (ESP)  -- if use ```--opt encrypted``` create overlay network 

```
qa@k8s-01:~$ ss -tan | grep 2377
ESTAB    0      0                172.18.42.31:59290          172.18.42.32:2377
ESTAB    0      0                172.18.42.31:49432          172.18.42.33:2377
LISTEN   0      128                         *:2377                      *:*
ESTAB    0      0       [::ffff:172.18.42.31]:2377  [::ffff:172.18.42.32]:45820
ESTAB    0      0       [::ffff:172.18.42.31]:2377  [::ffff:172.18.42.35]:45988
ESTAB    0      0       [::ffff:172.18.42.31]:2377  [::ffff:172.18.42.33]:44386
ESTAB    0      0       [::ffff:172.18.42.31]:2377  [::ffff:172.18.42.32]:45818
ESTAB    0      0       [::ffff:172.18.42.31]:2377  [::ffff:172.18.42.34]:37570
qa@k8s-01:~$ ss -tan | grep 7946
TIME-WAIT0      0                172.18.42.31:56386          172.18.42.34:7946
TIME-WAIT0      0                172.18.42.31:47958          172.18.42.36:7946
TIME-WAIT0      0                172.18.42.31:34902          172.18.42.33:7946
TIME-WAIT0      0                172.18.42.31:47960          172.18.42.36:7946
LISTEN   0      128                         *:7946                      *:*
```

## Create new docker swarm

``` docker swarm init --advertise-addr <MANAGER-IP>```
use ``` docker swarm init ``` when host only have one NIC .

Add work node :
```
docker swarm join --token SWMTKN-1-0d5x6m0xm1fq5j9dzi2o4erpwxffjdd8wi7vt5f6g8agv4lvbp-cmq0yqfoci4ajejs7x9gn8e5o 192.168.0.28:2377
## on all node need to join the swarm 
```

Verify node on Swarm Leader and Promote work node to manage node
```
$ docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
whtsvmmle4x4mzi28r0boyhtd *   node1      Ready     Active         Leader           20.10.0
z3fjqs2270zspp86n1gtzq95m     node2      Ready     Active                          20.10.0
j8925yteonrg26793cesz4b72     node3      Ready     Active                          20.10.0
[node1] (local) root@192.168.0.28 ~
$ docker node promote --help 

Usage:  docker node promote NODE [NODE...]

Promote one or more nodes to manager in the swarm
[node1] (local) root@192.168.0.28 ~
$ docker node promote z3fjqs2270zspp86n1gtzq95m
Node z3fjqs2270zspp86n1gtzq95m promoted to a manager in the swarm.
[node1] (local) root@192.168.0.28 ~
$ docker node promote j8925yteonrg26793cesz4b72
Node j8925yteonrg26793cesz4b72 promoted to a manager in the swarm.
[node1] (local) root@192.168.0.28 ~
$ docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
whtsvmmle4x4mzi28r0boyhtd *   node1      Ready     Active         Leader           20.10.0
z3fjqs2270zspp86n1gtzq95m     node2      Ready     Active         Reachable        20.10.0
j8925yteonrg26793cesz4b72     node3      Ready     Active         Reachable        20.10.0
```

```bash 
qa@k8s-01:~$ docker swarm ca
-----BEGIN CERTIFICATE-----
MIIBajCCARCgAwIBAgIUH4v0/BdLzTdmtEQHpiO/0sWKFGkwCgYIKoZIzj0EAwIw
EzERMA8GA1UEAxMIc3dhcm0tY2EwHhcNMjEwNjA0MDQxNjAwWhcNNDEwNTMwMDQx
NjAwWjATMREwDwYDVQQDEwhzd2FybS1jYTBZMBMGByqGSM49AgEGCCqGSM49AwEH
A0IABEkdBiyv4j5i0AIxVZoURwaZwIUzt3YNVt/aF+IXFKMw7plAmrPV+RX6iCbC
sUNMlOca3a3qwtx3zFhbc/bFfXWjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MB0GA1UdDgQWBBTv8utHcvZCa7+XQmIdkBvxvJQ7SDAKBggqhkjO
PQQDAgNIADBFAiAOXhmWq54/wMXt/cCAVlKFoXnlv/Yb0qoNF1JAkdJPHAIhAKTI
SCmFlPmUTqvvYdM+H+pVVSDHwAC2nnPMG3RGlH7J
-----END CERTIFICATE-----

docker swarm join|leave|unlock
```
