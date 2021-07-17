
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
