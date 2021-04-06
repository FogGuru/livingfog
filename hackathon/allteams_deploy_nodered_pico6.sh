#!/bin/bash
#fill it with the namespce. e.g. "varnamespace=team1-namespace"
export myclusterIP=192.168.9.60
export port=1886
varnamespace=team6-namespace

kubectl apply -f ./nodered/deployment.yml --namespace $varnamespace
envsubst < ./nodered/service.yml | kubectl apply --namespace $varnamespace -f -
################################################################################
export port=1893
varnamespace=team13-namespace

kubectl apply -f ./nodered/deployment.yml --namespace $varnamespace
envsubst < ./nodered/service.yml | kubectl apply --namespace $varnamespace -f -
################################################################################