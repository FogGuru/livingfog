picoip=https://192.168.9.30:6443
clustername=picocluster3
mkdir pico3

export varnamespace=team1-namespace
export varsaname=team1-sa
username=team1-picocluster3-user
contextname=team1-pico3-context
configname=pico3/team1-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team2-namespace
export varsaname=team2-sa
username=team2-picocluster3-user
contextname=team2-pico3-context
configname=pico3/team2-pico3-config

#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team3-namespace
export varsaname=team3-sa
username=team3-picocluster3-user
contextname=team3-pico3-context
configname=pico3/team3-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team4-namespace
export varsaname=team4-sa
username=team4-picocluster3-user
contextname=team4-pico3-context
configname=pico3/team4-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team5-namespace
export varsaname=team5-sa
username=team5-picocluster3-user
contextname=team5-pico3-context
configname=pico3/team5-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team6-namespace
export varsaname=team6-sa
username=team6-picocluster3-user
contextname=team6-pico3-context
configname=pico3/team6-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team7-namespace
export varsaname=team7-sa
username=team7-picocluster3-user
contextname=team7-pico3-context
configname=pico3/team7-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team8-namespace
export varsaname=team8-sa
username=team8-picocluster3-user
contextname=team8-pico3-context
configname=pico3/team8-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team9-namespace
export varsaname=team9-sa
username=team9-picocluster3-user
contextname=team9-pico3-context
configname=pico3/team9-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team10-namespace
export varsaname=team10-sa
username=team10-picocluster3-user
contextname=team10-pico3-context
configname=pico3/team10-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team11-namespace
export varsaname=team11-sa
username=team11-picocluster3-user
contextname=team11-pico3-context
configname=pico3/team11-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team12-namespace
export varsaname=team12-sa
username=team12-picocluster3-user
contextname=team12-pico3-context
configname=pico3/team12-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team13-namespace
export varsaname=team13-sa
username=team13-picocluster3-user
contextname=team13-pico3-context
configname=pico3/team13-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team14-namespace
export varsaname=team14-sa
username=team14-picocluster3-user
contextname=team14-pico3-context
configname=pico3/team14-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team15-namespace
export varsaname=team15-sa
username=team15-picocluster3-user
contextname=team15-pico3-context
configname=pico3/team15-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team16-namespace
export varsaname=team16-sa
username=team16-picocluster3-user
contextname=team16-pico3-context
configname=pico3/team16-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team17-namespace
export varsaname=team17-sa
username=team17-picocluster3-user
contextname=team17-pico3-context
configname=pico3/team17-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team18-namespace
export varsaname=team18-sa
username=team18-picocluster3-user
contextname=team18-pico3-context
configname=pico3/team18-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team19-namespace
export varsaname=team19-sa
username=team19-picocluster3-user
contextname=team19-pico3-context
configname=pico3/team19-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################
export varnamespace=team20-namespace
export varsaname=team20-sa
username=team20-picocluster3-user
contextname=team20-pico3-context
configname=pico3/team20-pico3-config
#create namespace
envsubst < ./team-namespace.yaml | kubectl apply -f -

#create service account for the team
envsubst < ./team-sa-create.yaml | kubectl apply -f -

#create an admin role for the specified namespace
envsubst < ./team-admin-role.yaml | kubectl apply -f -

#see the roles
kubectl get roles --namespace $varnamespace

#bind the role to a user
envsubst < ./team-admin-role-binding.yaml | kubectl apply -f -

#see the bindings
kubectl get rolebinding --namespace $varnamespace

# the name of the secret containing the service account token goes here
secretname=$(kubectl get serviceaccounts/$varsaname --namespace $varnamespace -o jsonpath='{.secrets[0].name}')
ca=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret $secretname -n $varnamespace -o jsonpath='{.data.namespace}' | base64 --decode)

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
################################################################################