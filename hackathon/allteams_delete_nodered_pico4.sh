#!/bin/bash
#fill it with the namespce. e.g. "varnamespace=team1-namespace"
export myclusterIP=192.168.9.40
export port=1884
varnamespace=team4-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################
export port=1891
varnamespace=team11-namespace

kubectl delete -n $varnamespace -f ./nodered/
################################################################################