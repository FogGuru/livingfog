# your server name goes here
picoip=[https://192.168.9.10:6443]
varnamespace=[team1-namespace]
varsaname=[team1-sa]
# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)
clustername=picocluster1
username=team1-picocluster1-user
contextname=team1-pico1-context
configname=team1-pico1-config

echo "
apiVersion: v1
kind: Config
name: ${configname}
clusters:
- cluster:
    certificate-authority-data: ${ca}
    server: ${picoip}
  name: ${clustername}
contexts:
- context:
    cluster: ${clustername}
    namespace: ${namespace}
    user: ${username}
  name: ${contextname}
current-context: ${contextname}
users:
- name: ${username}
  user:
    token: ${token}
" > ${configname}
