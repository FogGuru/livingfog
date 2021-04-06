#!/bin/bash
#fill it with the namespce. e.g. "varnamespace=team1-namespace"
export myclusterIP=192.168.9.10

export port=1881
varnamespace=team1-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################
export port=1888
varnamespace=team8-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################
export port=1895
varnamespace=team15-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################