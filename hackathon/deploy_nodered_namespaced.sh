#!/bin/bash
#fill it with the namespce. e.g. "varnamespace=team1-namespace"
varnamespace=[team1-namespace]

kubectl apply -f ./nodered/deployment.yml --namespace $varnamespace
envsubst < ./nodered/service.yml | kubectl apply --namespace $varnamespace -f -
