#!/bin/bash

kubectl delete -f ./mosquitto/
kubectl delete -f ./influxdb/
kubectl delete -f ./postgres/
kubectl delete -k redis/.
kubectl delete -f ./chirpstack-network-server/
kubectl delete -f ./chirpstack-application-server/
kubectl delete -f ./monitoring/
kubectl delete -f ./nodered/
kubectl delete pvc mosquitto postgres-pv-claim postgresinit-pv-claim
kubectl delete pv mosquitto-pv-volume postgres-pv-volume postgresinit-pv-volume