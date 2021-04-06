#!/bin/bash
#fill it with the namespce. e.g. "varnamespace=team1-namespace"
varnamespace=team1-namespace

kubectl delete -n $varnamespace -f ./nodered/
