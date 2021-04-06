#!/bin/bash
#fill it with the namespce. e.g. "varnamespace=team1-namespace"
export myclusterIP=192.168.9.20

export port=1882
varnamespace=team2-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################
export port=1889
varnamespace=team9-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################
export port=1896
varnamespace=team16-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################