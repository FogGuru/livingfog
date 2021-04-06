#!/bin/bash

kubectl apply -f ./mosquitto/mosquitto-glusterfs-endpoint.yaml
kubectl apply -f ./mosquitto/storage.yml
kubectl apply -f ./mosquitto/configmap.yaml
kubectl apply -f ./mosquitto/deployment.yml
envsubst < ./mosquitto/service.yml | kubectl apply -f -

kubectl apply -f ./influxdb/influxdb-glusterfs-endpoint.yaml
kubectl apply -f ./influxdb/storage.yml
kubectl apply -f ./influxdb/deployment.yml
envsubst < ./influxdb/service.yml | kubectl apply -f -

kubectl apply -f ./postgres/
kubectl apply -k redis/.

kubectl apply -f ./chirpstack-network-server/configMap.yml
kubectl apply -f ./chirpstack-network-server/deployment.yml
envsubst < ./chirpstack-network-server/service.yml | kubectl apply -f -

kubectl apply -f ./chirpstack-application-server/configMap.yml
kubectl apply -f ./chirpstack-application-server/deployment.yml
envsubst < ./chirpstack-application-server/service.yml | kubectl apply -f -

kubectl apply -f ./monitoring/configmap.yaml
kubectl apply -f ./monitoring/kube-state-metrics.yaml
kubectl apply -f ./monitoring/node-exporter.yaml
kubectl apply -f ./monitoring/rbac.yaml
envsubst < ./monitoring/grafana.yaml | kubectl apply -f -
envsubst < ./monitoring/prometheus.yaml | kubectl apply -f -

kubectl apply -f ./nodered/deployment.yml
envsubst < ./nodered/service.yml | kubectl apply -f -
