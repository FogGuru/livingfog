# Kubeadm Ansible Playbook

Build a Kubernetes cluster using Ansible with kubeadm. The goal is easily install a Kubernetes cluster.

System requirements:

  - Deployment environment must have Ansible `2.4.0+`
  - Master and nodes must have passwordless SSH access

### GlusterFS

We use glusterfs on the pico clusters as the file system on which Kubernetes creates PersistentVolumes.

Before running Ansible, make sure if there are any gluster volumes running by using the following command on the master node.
```
$ sudo gluster volume status
```

If there are any gluster volumes, first stop and delete them.

For example, run the following command to stop and delete the volumes `mosquitto_volume`, `postgre_volume` and `influxdb_volume`:

```
$ sudo gluster volume stop mosquitto_volume
$ sudo gluster volume stop postgre_volume
$ sudo gluster volume stop influxdb_volume
$ sudo gluster volume delete mosquitto_volume
$ sudo gluster volume delete influxdb_volume
$ sudo gluster volume delete postgre_volume
```

Also, make sure that the glusterfs volume replicas are set to `3` when running on PicoCluster10, and `2` when running on PicoCluster5. Edit all instances of `replicas` in file `roles/glusterfs/master/tasks/main.yml`

# Creating Kubernetes cluster

Add the system information gathered above into a file called `hosts.ini`. For example:
```
[master]
192.16.35.12

[node]
192.16.35.[10:11]

[kube-cluster:children]
master
node
```

If you're working with ubuntu, add the following properties to each host `ansible_python_interpreter='python3'`:
```
[master]
192.16.35.12 ansible_python_interpreter='python3'

[node]
192.16.35.[10:11] ansible_python_interpreter='python3'

[kube-cluster:children]
master
node

```

Before continuing, edit `group_vars/all.yml` to your specified configuration.

For example, we choose to run `flannel` instead of calico, and thus:

```yaml
# Network implementation('flannel', 'calico')
network: flannel
```

**Note:** Depending on your setup, you may need to modify `cni_opts` to an available network interface. By default, `kubeadm-ansible` uses `eth1`. Your default interface may be `eth0`.

**Note:** Edit the "master_vpn" variable in `all.yaml` file. The value should be equal to the IP address of the master node in the VPN interface.

After going through the setup, run the `site.yaml` playbook:

```sh
$ ansible-playbook -i hosts.ini site.yaml
...
==> master1: TASK [addon : Create Kubernetes dashboard deployment] **************************
==> master1: changed: [192.16.35.12 -> 192.16.35.12]
==> master1:
==> master1: PLAY RECAP *********************************************************************
==> master1: 192.16.35.10               : ok=18   changed=14   unreachable=0    failed=0
==> master1: 192.16.35.11               : ok=18   changed=14   unreachable=0    failed=0
==> master1: 192.16.35.12               : ok=34   changed=29   unreachable=0    failed=0
```

The playbook will download `/etc/kubernetes/admin.conf` file to `$HOME/admin.conf`.

If it doesn't work download the `admin.conf` from the master node:

```sh
$ scp k8s@k8s-master:/etc/kubernetes/admin.conf .
```

Verify cluster is fully running using kubectl:

```sh

$ export KUBECONFIG=~/admin.conf
$ kubectl get node
NAME      STATUS    AGE       VERSION
master1   Ready     22m       v1.6.3
node1     Ready     20m       v1.6.3
node2     Ready     20m       v1.6.3

$ kubectl get po -n kube-system
NAME                                    READY     STATUS    RESTARTS   AGE
etcd-master1                            1/1       Running   0          23m
...
```

# Resetting the environment

If you want to reset all kubeadm installed state, use `reset-site.yaml` playbook:

```sh
$ ansible-playbook reset-site.yaml
```

# Changing the password
If you need to change the default password of the user picocluster, run from `kubeadm-ansible` directory:
```
ansible-playbook -i hosts.ini change-password.yml --extra-vars newpassword=NEWPASSWORD
```

# Updating the `/etc/resolv.conf` file in all nodes for fast name resolution

On each master node go to `kubeadm-ansible` directory, check the `hosts.ini` file for correctness, and run:
```
ansible-playbook -i hosts.ini copy-resolv-conf.yml
```

# For more information
This repo is forked and edited from https://github.com/kairen/kubeadm-ansible
See the original repo for additional features.

### If you want to set the fixed version of K8s: 

Edit `/roles/kubernetes/master/meta` 
```
kubelet=1.18.0-00", "kubeadm=1.18.0-00", "kubectl=1.18.0-00
```
Edit `/roles/kubeadm/node/meta`
```
kubelet=1.18.0-00", "kubeadm=1.18.0-00
```

### If you want to set the network implementation
Edit `/group_vars/all.yml`
```
kube_version: v1.18.0
...
network: flannel
```
