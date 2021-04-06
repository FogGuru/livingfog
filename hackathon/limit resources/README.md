# Limit the resource usage for a namespace
Each fog cluster has 4 cpu cores and 4 GB RAM.

This quota file specifies a limit on the CPU and RAM usages of a namespace in the cluster. We designed this limit as 1/4 of the said available resources on the cluster. 

Note: We may adapt these amounts of resources during the hackathon depending on the needs of the teams

The teams should declare the required resources in their manifest files as shown the sample YAML file inside the Example folder.

To activate quota for a namespace, run the following command:

	kubectl apply -f ./quota.yaml --namespace=[team1-namespace]

Now following requirements are imposed to the namespace:
	
1.Every Container must have a memory request, memory limit, cpu request, and cpu limit.

2.The memory request total for all Containers must not exceed 1 GiB.

3.The memory limit total for all Containers must not exceed 2 GiB.

4.The CPU request total for all Containers must not exceed 1 cpu.

5.The CPU limit total for all Containers must not exceed 2 cpu.


## Specify default limit ranges for RAM usage
	kubectl apply -f ./default-mem-limits.yaml --namespace=[team1-namespace]

## Specify default limit ranges for CPU usage
	kubectl apply -f ./default-cpu-limits.yaml --namespace=[team1-namespace]
