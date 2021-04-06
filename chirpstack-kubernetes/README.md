# Deploy chirpstack and software stack with kubernetes

### Replace your cluster ip with [myclusterIP] value
myclusterIP is the host IP address, acts as a manager in GlusterFS

```
$ export myclusterIP=192.168.1.10
```

### Generate GlusterFS Endpoints files
Edit the IP address range in the `generate_glusterfs_endpoints.sh` file first using a text editor

```
for i in {11..19} -> change your cluster address range here
do
echo "- addresses:
  - ip: 192.168.9.$i
  ports:
```

Run the glusterFS generation script
```
$ ./generate_glusterfs_endpoints.sh
```

## Deploying
Run following to deploy all software stack
```
$ sh ./deploy_all.sh
```

After running the deployment, wait for them to fully deployed
```
$ kubectl get pods
```

```
NAME                                             READY   STATUS    RESTARTS   AGE
chirpstack-application-server-846d8b8f8d-jn88r   1/1     Running   0          1m
chirpstack-network-server-59dbd7845d-t7qqv       1/1     Running   0          1m
influx-9f69d79dd-8zq8v                           1/1     Running   0          1m
mosquitto-6c88b5b6f4-g4z99                       1/1     Running   0          1m
nodered-7b6cf58d46-526zk                         1/1     Running   0          1m
postgres-6995bb955c-sklm5                        1/1     Running   0          1m
redis                                            1/1     Running   0          1m
```

After the pod creation, create the databases:
```
$ sh ./postgres/create_db.sh
$ sh ./influxdb/create_users.sh
```

## Deleting
If you want to delete the stack, run following to delete all:
```
$ sh ./delete_all.sh
```

## Debugging
You can run the following commands step by step to debug the Deployment stage:
```
$ kubectl apply -f ./mosquitto/mosquitto-glusterfs-endpoint.yaml
$ kubectl apply -f ./mosquitto/storage.yml
$ kubectl apply -f ./mosquitto/configmap.yaml
$ kubectl apply -f ./mosquitto/deployment.yml
$ envsubst < ./mosquitto/service.yml | kubectl apply -f -

$ kubectl apply -f ./influxdb/influxdb-glusterfs-endpoint.yaml
$ kubectl apply -f ./influxdb/storage.yml
$ kubectl apply -f ./influxdb/deployment.yml
$ envsubst < ./influxdb/service.yml | kubectl apply -f -

$ kubectl apply -f ./postgres/
$ kubectl apply -k redis/.

$ kubectl apply -f ./chirpstack-network-server/configMap.yml
$ kubectl apply -f ./chirpstack-network-server/deployment.yml
$ envsubst < ./chirpstack-network-server/service.yml | kubectl apply -f -

$ kubectl apply -f ./chirpstack-application-server/configMap.yml
$ kubectl apply -f ./chirpstack-application-server/deployment.yml
$ envsubst < ./chirpstack-application-server/service.yml | kubectl apply -f -

$ kubectl apply -f ./monitoring/configmap.yaml
$ kubectl apply -f ./monitoring/kube-state-metrics.yaml
$ kubectl apply -f ./monitoring/node-exporter.yaml
$ kubectl apply -f ./monitoring/rbac.yaml
$ envsubst < ./monitoring/grafana.yaml | kubectl apply -f -
$ envsubst < ./monitoring/prometheus.yaml | kubectl apply -f -

$ kubectl apply -f ./nodered/deployment.yml
$ envsubst < ./nodered/service.yml | kubectl apply -f -
```

You can run the following commands step by step to debug the Deleting stage
```
$ kubectl delete -f ./mosquitto/
$ kubectl delete -f ./influxdb/
$ kubectl delete -f ./postgres/
$ kubectl delete -k redis/.
$ kubectl delete -f ./chirpstack-network-server/
$ kubectl delete -f ./chirpstack-application-server/
$ kubectl delete -f ./monitoring/
$ kubectl delete -f ./nodered/
$ kubectl delete pvc mosquitto postgres-pv-claim postgresinit-pv-claim
$ kubectl delete pv mosquitto-pv-volume $ postgres-pv-volume postgresinit-pv-volume
```

## Exposing to external IPs
Kubernetes services are exposing external IPs to access from outside, you can enable/disable exposing IP addresses at the end of following files:
```
port:8080  /chirpstack-application-server/service.yml
port:8000  /chirpstack-network-server/service.yml
port:9090  /monitoring/prometheus.yaml
port:3000  /monitoring/grafana.yaml
port:1883  /mosquitto/service.yml
port:8086  /influxdb/service.yml
port:1880  /nodered/service.yml
```
End of the file looks like
```
externalIPs:
- $myclusterIP
```

## Logging

The logging infrastructure is based on Fluentbit, ElasticSearch and Kibana.

Fluentbit is deployed on the master nodes of each fog cluster as a daemonset, to capture control plane events only (e.g., creation of a pod, etc.).

Fluentbit is configured to push the logs to ElasticSearch which is deployed on the central server.

Kibana, also deployed on the central server, is used to search and visualize the logs from ElasticSearch.

Check the ElasticSearch and Kibana deployment documentaion in the central server.

To deploy Fluentbit on the fog clusters, first update the `Logstash_Prefix` in `logging/fluent-bit-configmap.yaml` file to the cluster name.

Next, deploy using
```
kubectl create namespace logging
kubectl apply -f logging/
```
