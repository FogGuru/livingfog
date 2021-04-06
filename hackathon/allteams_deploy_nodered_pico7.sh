#!/bin/bash
#fill it with the namespce. e.g. "varnamespace=team1-namespace"
export myclusterIP=192.168.9.65
export port=1887
varnamespace=team7-namespace

kubectl apply -f ./nodered/deployment.yml --namespace $varnamespace
envsubst < ./nodered/service.yml | kubectl apply --namespace $varnamespace -f -
################################################################################
export port=1894
varnamespace=team14-namespace

kubectl apply -f ./nodered/deployment.yml --namespace $varnamespace
envsubst < ./nodered/service.yml | kubectl apply --namespace $varnamespace -f -
################################################################################