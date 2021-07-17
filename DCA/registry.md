# use registry

## default registry
Default registry is docker hub the URL is ** https://hub.docker.com **

## other public registry 
To add CA certificate
``` bash
scp harborhost://harbor/cert/path/ca.crt /usr/local/share/ca-certificate/ca.crt
sudo update-ca-certificates
sudo systemctl restart docker.service

```
# build your own registry

## by docker registry

## by VMware harbor
