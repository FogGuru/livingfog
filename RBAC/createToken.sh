export varnamespace=[team1-namespace]
export varsaname=[team1-sa]

#get service account properties
name=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
#get the token based on the output of the previous command
kubectl describe secrets/$name -n $varnamespace


