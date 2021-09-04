# Q1 namespace

Task weight: 1%

The DevOps team would like to get the list of all Namespaces in the cluster. Get the list and save it to /opt/course/1/namespaces

# Q2 create pod with name

Task weight: 3%

Create a single Pod of image httpd:2.4.41-alpine in Namespace default. The Pod should be named pod1 and the container should be named pod1-container.

Your manager would like to run a command manually on occasion to output the status of that exact Pod. Please write a command that does this into /opt/course/2/pod1-status-command.sh. The command should use kubectl.

```
k8s@terminal:~$ vim /opt/course/2/pod1-status-command.sh
k8s@terminal:~$ chmod +x /opt/course/2/pod1-status-command.sh
k8s@terminal:~$ /opt/course/2/pod1-status-command.sh
NAME   READY   STATUS    RESTARTS   AGE
pod1   1/1     Running   0          105s
k8s@terminal:~$ /opt/course/2/pod1-status-command.sh
NAME   READY   STATUS    RESTARTS   AGE
pod1   1/1     Running   0          109s
```

# Q3 Job {label, namespace , parallel }
Task weight: 3%

Team Neptune needs a Job template located at /opt/course/3/job.yaml. This Job should run image busybox:1.31.0 and execute sleep 2 && echo done. It should be in namespace neptune, run a total of 3 times and should execute 2 runs in parallel.

Start the Job and check its history. Each pod created by the Job should have the label id: awesome-job. The job should be named neb-new-job and the container neb-new-job-container.

# Q4 Deployment { Limit Memory , ServiceAccount}
Task weight: 4%

Team Neptune needs 3 Pods of image httpd:2.4-alpine, create a Deployment named neptune-10ab for this. The containers should be named neptune-pod-10ab. Each container should have a memory request of 20Mi and a memory limit of 50Mi.

Team Neptune has its own ServiceAccount neptune-sa-v2 under which the Pods should run. The Deployment should be in Namespace neptune.

q4.yaml:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: neptune-10ab
  labels:
    app: httpd
spec:
  replicas: 3
  selector:
    matchLabels:
      app: httpd
  template:
    metadata:
      labels:
        app: httpd
    spec:
      containers:
      - name: neptune-pod
        image: httpd:2.4-alpine
        resources:
          requests:
            memory: "20Mi"
          limits:
            memory: "50Mi"
```

cli change limit 
```
kubectl set resources deployment.v1.apps/nginx-deployment -c=nginx --limits=cpu=200m,memory=512Mi
```
# Q5 ServiceAccount {base64, token}

Task weight: 3%

Team Neptune has its own ServiceAccount named neptune-sa-v2 in Namespace neptune. A coworker needs the token from the Secret that belongs to that ServiceAccount. Write the base64 decoded token to file /opt/course/5/token.

```
kubectl create serviceaccount neptune-as-v2 --namespace neptune
```

# Q6 probe{wait, periodically, test file exists}

Task weight: 7%

Create a single Pod named pod6 in Namespace default of image busybox:1.31.0. The Pod should have a readiness-probe executing cat /tmp/ready. It should initially wait 5 and periodically wait 10 seconds. This will set the container ready only if the file /tmp/ready exists.

The Pod should run the command touch /tmp/ready && sleep 1d, which will create the necessary file to be ready and then idles. Create the Pod and confirm it starts.

# Q7 move Namespace -- pod should not stop anytime

Task weight: 4%

The board of Team Neptune decided to take over control of one e-commerce webserver from Team Saturn. The administrator who once setup this webserver is not part of the organisation any longer. All information you could get was that the e-commerce system is called my-happy-shop.

Search for the correct Pod in Namespace saturn and move it to Namespace neptune. It doesn't matter if you shut it down and spin it up again, it probably hasn't any customers anyways.

# Q8 Troubleshooting Deployments
Task weight: 4%

There is an existing Deployment named api-new-c32 in Namespace neptune. A developer did make an update to the Deployment but the updated version never came online. Check the Deployment history and find a revision that works, then rollback to it. Could you tell Team Neptune what the error was so it doesn't happen again?


```
k8s@terminal:~$ k describe  deployment api-new-c32 -n neptune
Name:                   api-new-c32
Namespace:              neptune
CreationTimestamp:      Tue, 11 May 2021 13:08:08 +0000
Labels:                 id=api-new-c32
Annotations:            deployment.kubernetes.io/revision: 4
                        kubernetes.io/change-cause: kubectl edit deployment api-new-c32 --namespace=neptune
Selector:               id=api-new-c32
Replicas:               3 desired | 1 updated | 4 total | 3 available | 1 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  id=api-new-c32
  Containers:
   nginx:
    Image:        ngnix:1.16.3
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    False   ProgressDeadlineExceeded
OldReplicaSets:  api-new-c32-798b859cdf (3/3 replicas created)
NewReplicaSet:   api-new-c32-6775dbd89c (1/1 replicas created)
Events:          <none>


k8s@terminal:~$ k get pods -n neptune
NAME                            READY   STATUS             RESTARTS   AGE
api-new-c32-6775dbd89c-77njh    0/1     ImagePullBackOff   0          116d
api-new-c32-798b859cdf-fqxtn    1/1     Running            0          116d
api-new-c32-798b859cdf-r87b2    1/1     Running            0          116d
api-new-c32-798b859cdf-sqx4d    1/1     Running            0          116d


##########
Events:
  Type    Reason   Age                     From     Message
  ----    ------   ----                    ----     -------
  Normal  BackOff  4m24s (x268 over 116d)  kubelet  Back-off pulling image "ngnix:1.16.3"

```

# Q9 convert pod to deployments by yaml

Task weight: 8%

In Namespace pluto there is single Pod named holy-api. It has been working okay for a while now but Team Pluto needs it to be more reliable. Convert the Pod into a Deployment with 3 replicas and name holy-api. The raw Pod template file is available at /opt/course/9/holy-api-pod.yaml.

Please create the Deployment and save its yaml under /opt/course/9/holy-api-deployment.yaml.

```
k8s@terminal:~$ more /opt/course/9/holy-api-pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    id: holy-api
  name: holy-api
  namespace: pluto
spec:
  volumes:
  - name: cache-volume1
    emptyDir: {}
  - name: cache-volume2
    emptyDir: {}
  - name: cache-volume3
    emptyDir: {}
  containers:
  - image: nginx:1.17.3-alpine
    name: holy-api-container
    volumeMounts:
    - mountPath: /cache1
      name: cache-volume1
    - mountPath: /cache2
      name: cache-volume2
    - mountPath: /cache3
      name: cache-volume3
    env:
    - name: CACHE_KEY_1
      value: "b&MTCi0=[T66RXm!jO@"
    - name: CACHE_KEY_2
      value: "PCAILGej5Ld@Q%{Q1=#"
    - name: CACHE_KEY_3
      value: "2qz-]2OJlWDSTn_;RFQ"
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
# Q10 Netowrk {ClusterIP, label , verify by curl , verify log}
Task weight: 4%

Team Pluto needs a new cluster internal Service. Create a ClusterIP Service named project-plt-6cc-svc in Namespace pluto. This Service should expose a single Pod named project-plt-6cc-api of image nginx:1.17.3-alpine, create that Pod as well. The Pod should be identified by label project: plt-6cc-api. The Service should use tcp port redirection of 3333:80.

Finally use for example curl from a temporary nginx:alpine Pod to get the response from the Service. Write the response into /opt/course/10/service_test.html. Also check if the logs of Pod project-plt-6cc-api show the request and write those into /opt/course/10/service_test.log.

# Q11 label and annotation {add label and annotation while not delete pod}
Task weight: 3%

Team Sunny needs to identify some of their Pods in namespace sun. They ask you to add a new label protected: true to all Pods with an existing label type: worker or type: runner. Also add an annotation protected: do not delete this pod to all Pods having the new label protected: true.

# Q12 PV/PVC
Task weight: 10%

Create a new PersistentVolume named earth-project-earthflower-pv. It should have a capacity of 2Gi, accessMode ReadWriteOnce, hostPath /Volumes/Data and no storageClassName defined.

Next create a new PersistentVolumeClaim in Namespace earth named earth-project-earthflower-pvc . It should request 2Gi storage, accessMode ReadWriteOnce and should not define a storageClassName. The PVC should bound to the PV correctly.

Finally create a new Deployment project-earthflower in Namespace earth which mounts that volume at /tmp/project-data. The Pods of that Deployment should be of image httpd:2.4.41-alpine.


# Q13 PVC
Task weight: 7%

Team Moonpie, which has the Namespace moon, needs more storage. Create a new PersistentVolumeClaim named moon-pvc-126 in that namespace. This claim should use a new StorageClass moon-retain with the provisioner set to moon-retainer and the reclaimPolicy set to Retain. The claim should request storage of 3Gi, an accessMode of ReadWriteOnce and should use the new StorageClass.

The provisioner moon-retainer will be created by another team, so it's expected that the PVC will not boot yet. Confirm this by writing the log message from the PVC into file /opt/course/13/pvc-126-reason.

# Q14 

Task weight: 4%

You need to make changes on an existing Pod in Namespace moon called secret-handler. Create a new Secret secret1 which contains user=test and pass=pwd. The Secret's content should be available in Pod secret-handler as environment variables SECRET1_USER and SECRET1_PASS. The yaml for Pod secret-handler is available at /opt/course/14/secret-handler.yaml.

There is existing yaml for another Secret at /opt/course/14/secret2.yaml, create this Secret and mount it inside the same Pod at /tmp/secret2. Your changes should be saved under /opt/course/14/secret-handler-new.yaml. Both Secrets should only be available in Namespace moon.

# Q15 ConfigureMap {contain a file}
Task weight: 5%

Team Moonpie has a nginx server Deployment called web-moon in Namespace moon. Someone started configuring it but it was never completed. To complete please create a ConfigMap called configmap-web-moon-html containing the content of file /opt/course/15/web-moon.html under the data key-name index.html.

The Deployment web-moon is already configured to work with this ConfigMap and serve its content. Test the nginx configuration for example using curl from a temporary nginx:alpine Pod.

# Q16
Task weight: 6%

The Tech Lead of Mercury2D decided its time for more logging, to finally fight all these missing data incidents. There is an existing container named cleaner-con in Deployment cleaner in Namespace mercury. This container mounts a volume and writes logs into a file called cleaner.log.

The yaml for the existing Deployment is available at /opt/course/16/cleaner.yaml. Persist your changes at /opt/course/16/cleaner-new.yaml but also make sure the Deployment is running.

Create a sidecar container named logger-con, image busybox:1.31.0 , which mounts the same volume and writes the content of cleaner.log to stdout, you can use the tail -f command for this. This way it can be picked up by kubectl logs.

Check if the logs of the new container reveal something about the missing data incidents.

```
k8s@terminal:~$ more /opt/course/16/cleaner.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  name: cleaner
  namespace: mercury
spec:
  replicas: 2
  selector:
    matchLabels:
      id: cleaner
  template:
    metadata:
      labels:
        id: cleaner
    spec:
      volumes:
      - name: logs
        emptyDir: {}
      initContainers:
      - name: init
        image: bash:5.0.11
        command: ['bash', '-c', 'echo init > /var/log/cleaner/cleaner.log']
        volumeMounts:
        - name: logs
          mountPath: /var/log/cleaner
      containers:
      - name: cleaner-con
        image: bash:5.0.11
        args: ['bash', '-c', 'while true; do echo `date`: "remove random file" >> /var/log/cleaner/cleaner.log; sleep 1; done']
        volumeMounts:
        - name: logs
          mountPath: /var/log/cleaner
```

# Q17 InitContainer
Task weight: 4%

Last lunch you told your coworker from department Mars Inc how amazing InitContainers are. Now he would like to see one in action. There is a Deployment yaml at /opt/course/17/test-init-container.yaml. This Deployment spins up a single Pod of image nginx:1.17.3-alpine and serves files from a mounted volume, which is empty right now.

Create an InitContainer named init-con which also mounts that volume and creates a file index.html with content check this out! in the root of the mounted volume. For this test we ignore that it doesn't contain valid html.

The InitContainer should be using image busybox:1.31.0. Test your implementation for example using curl from a temporary nginx:alpine Pod.

# Q18 troubleshooting { use tmp pod , enter pod}

Task weight: 5%

There seems to be an issue in Namespace mars where the ClusterIP service manager-api-svc should make the Pods of Deployment manager-api-deployment available inside the cluster.

You can test this with curl manager-api-svc.mars:4444 from a temporary nginx:alpine Pod. Check for the misconfiguration and apply a fix.


# Q19 modify ClusterIP to NodePort
Task weight: 3%

In Namespace jupiter you'll find an apache Deployment (with one replica) named jupiter-crew-deploy and a ClusterIP Service called jupiter-crew-svc which exposes it. Change this service to a NodePort one to make it available on all nodes on port 30100.

Test the NodePort Service using the internal IP of all available nodes and the port 30100 using curl, you can reach the internal node IPs directly from your main terminal. On which nodes is the Service reachable? On which node is the Pod running?

## Services
```
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"jupiter-crew-svc","namespace":"jupiter"},"spec":{"ports":[{"name":"8080-80","port":8080,"protocol":"TCP","targetPort":80}],"selector":{"id":"jupiter-crew"},"type":"ClusterIP"}}
  creationTimestamp: "2021-05-11T13:08:05Z"
  name: jupiter-crew-svc
  namespace: jupiter
  resourceVersion: "2024"
  uid: 5494b07a-11a8-42d1-884a-1efa258262b9
spec:
  clusterIP: 10.100.255.41
  clusterIPs:
  - 10.100.255.41
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - name: 8080-80
    port: 8080
    protocol: TCP
    targetPort: 80
  selector:
    id: jupiter-crew
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
  ```

## deployment
```
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"jupiter-crew-deploy","namespace":"jupiter"},"spec":{"replicas":1,"selector":{"matchLabels":{"id":"jupiter-crew"}},"template":{"metadata":{"labels":{"id":"jupiter-crew"}},"spec":{"containers":[{"image":"httpd:2.4.41-alpine","name":"apache"}]}}}}
  creationTimestamp: "2021-05-11T13:08:07Z"
  generation: 1
  name: jupiter-crew-deploy
  namespace: jupiter
  resourceVersion: "4722"
  uid: 6b088402-9827-49d4-b26a-04846f801fb8
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      id: jupiter-crew
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        id: jupiter-crew
    spec:
      containers:
      - image: httpd:2.4.41-alpine
        imagePullPolicy: IfNotPresent
        name: apache
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2021-05-11T13:08:07Z"
    lastUpdateTime: "2021-05-11T13:10:13Z"
    message: ReplicaSet "jupiter-crew-deploy-6785c47f64" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  - lastTransitionTime: "2021-05-11T13:22:29Z"
    lastUpdateTime: "2021-05-11T13:22:29Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
```

# Q20 NetworkPolicy 

Task weight: 12%

In Namespace venus you'll find two Deployments named api and frontend. Both Deployments are exposed inside the cluster using Services. Create a NetworkPolicy named np1 which restricts outgoing tcp connections from Deployment frontend and only allows those going to Deployment api. Make sure the NetworkPolicy still allows outgoing traffic on UDP/TCP ports 53 for DNS resolution.

Test using: wget www.google.com and wget api:2222 from a Pod of Deployment frontend.

## Service api
```
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"api","namespace":"venus"},"spec":{"ports":[{"name":"2222-80","port":2222,"protocol":"TCP","targetPort":80}],"selector":{"id":"api"},"type":"ClusterIP"}}
  creationTimestamp: "2021-05-11T13:08:05Z"
  name: api
  namespace: venus
  resourceVersion: "2032"
  uid: b5125d63-99ab-491e-b1a5-e5c63f6ff32f
spec:
  clusterIP: 10.103.197.217
  clusterIPs:
  - 10.103.197.217
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - name: 2222-80
    port: 2222
    protocol: TCP
    targetPort: 80
  selector:
    id: api
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
```

## Service frontend
```
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"frontend","namespace":"venus"},"spec":{"ports":[{"name":"80","port":80,"protocol":"TCP","targetPort":80}],"selector":{"id":"frontend"},"type":"ClusterIP"}}
  creationTimestamp: "2021-05-11T13:08:05Z"
  name: frontend
  namespace: venus
  resourceVersion: "2036"
  uid: f8533d79-4288-4c3a-bb81-026ed7034afd
spec:
  clusterIP: 10.107.132.162
  clusterIPs:
  - 10.107.132.162
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - name: "80"
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    id: frontend
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
```

## deployment api
```
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"api","namespace":"venus"},"spec":{"replicas":2,"selector":{"matchLabels":{"id":"api"}},"template":{"metadata":{"labels":{"id":"api"}},"spec":{"containers":[{"image":"httpd:2.4.41-alpine","name":"python"}]}}}}
  creationTimestamp: "2021-05-11T13:08:10Z"
  generation: 1
  name: api
  namespace: venus
  resourceVersion: "4782"
  uid: d7ec0070-7eeb-4ca8-b8f8-bfe563727d16
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      id: api
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        id: api
    spec:
      containers:
      - image: httpd:2.4.41-alpine
        imagePullPolicy: IfNotPresent
        name: python
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
```

## deployment frontend
```
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"api","namespace":"venus"},"spec":{"replicas":2,"selector":{"matchLabels":{"id":"api"}},"template":{"metadata":{"labels":{"id":"api"}},"spec":{"containers":[{"image":"httpd:2.4.41-alpine","name":"python"}]}}}}
  creationTimestamp: "2021-05-11T13:08:10Z"
  generation: 1
  name: api
  namespace: venus
  resourceVersion: "4782"
  uid: d7ec0070-7eeb-4ca8-b8f8-bfe563727d16
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      id: api
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        id: api
    spec:
      containers:
      - image: httpd:2.4.41-alpine
        imagePullPolicy: IfNotPresent
        name: python
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
```