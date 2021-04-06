#!/bin/bash
#fill it with the namespce. e.g. "varnamespace=team1-namespace"
export myclusterIP=192.168.9.50
export port=1885
varnamespace=team5-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################
export port=1892
varnamespace=team12-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################