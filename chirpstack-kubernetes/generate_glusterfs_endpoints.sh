#!/bin/bash

# Generate GlusterFS endpoint for mosquitto, postgre and influxdb


echo "apiVersion: v1
kind: Endpoints
metadata:
  name: mosquitto-gluster
subsets:" > mosquitto/mosquitto-glusterfs-endpoint.yaml

echo "apiVersion: v1
kind: Endpoints
metadata:
  name: postgre-gluster
subsets:" > postgres/postgre-glusterfs-endpoint.yaml

echo "apiVersion: v1
kind: Endpoints
metadata:
  name: influxdb-gluster
subsets:" > influxdb/influxdb-glusterfs-endpoint.yaml


for i in {21..29}
do
echo "- addresses:
  - ip: 192.168.9.$i
  ports:
  - port: 49152
    protocol: TCP" >> mosquitto/mosquitto-glusterfs-endpoint.yaml
echo "- addresses:
  - ip: 192.168.9.$i
  ports:
  - port: 49153
    protocol: TCP" >> postgres/postgre-glusterfs-endpoint.yaml
echo "- addresses:
  - ip: 192.168.9.$i
  ports:
  - port: 49154
    protocol: TCP" >> influxdb/influxdb-glusterfs-endpoint.yaml
done
