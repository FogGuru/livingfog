# Specific requirements for the hackathon
The scripts are using the variables:
	$varnamespace is the namespace

The following two environment variables should be tuned:

export port=[e.g.1881] #the port for the nodered service. I suggest to use port 1881 for team1, 1882 for team2, etc.

export myclusterIP=[e.g.192.168.9.10] #the ip address of the picocluster

## Create node-red instance in $varnamespace namespace
For only one team on one cluster, run the following script:
	./deploy_nodered_namespaced.sh
For all the teams on one cluster, run the following script:
	./allteams_deploy_nodered_pico[#No.].sh 
	
	replace [#No] with the pico cluster number, for example:
	./allteams_deploy_nodered_pico1.sh 
	
### Delete node-red instance from $varnamespace namespace
For only one team on one cluster, run the following script:
	./delete_nodered_namespaced.sh
	
For all the teams on one cluster, run the following script:
	./allteams_delete_nodered_pico[#No.].sh 
	
	replace [#No] with the pico cluster number, for example:
	./allteams_delete_nodered_pico1.sh 
