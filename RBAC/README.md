# Role-based access control
The scripts are using two environment variables:
	$varnamespace is the namespace
	and 
	$varsaname the service account name

## Create necessary objects for the admin role of each team 
	./createRoles.sh

### Get the token for the role to login into the dashboard
	./createToken.sh

### Install kubectl in your computer using the guide provided by the official Kubernetes website

According to your operating system (OS), find the instructions to install kubectl below:

Linux OS: https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux
Mac OS: https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-macos
Windows OS: https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-windows

### Get the kubeconfig for your cluster
Change the value of variables according to the cluster IP and cluster name
$picoip
$varnamespace
$varsaname
$clustername
$username
$contextname
$configname

For only one team on one cluster, run the following script:
	./getConfig.sh

For all the teams on one cluster, run the following script:
	./allteams-create-credentials-pico[#No].sh  
	
	replace [#No] with the pico cluster number, for example:
	./allteams-create-credentials-pico1.sh

### Merge the kubeconfigs for each team

	KUBECONFIG=~/.kube/team1-pico1-config:~/.kube/team1-pico2-config:~/.kube/team1-pico3-config:~/.kube/team1-pico4-config:~/.kube/team1-pico5-config:~/.kube/team1-pico6-config:~/.kube/team1-pico7-config kubectl config view --flatten > ~/.kube/team1-all-config

### Test the kubeconfigs for each team

	kubectl config get-contexts

	kubectl --context [the-context-name] get pods

### Delete all the namespaces on one pico cluser

	./allteams-delete-credentials-pico.sh	