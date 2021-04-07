# Abstract
LivingFog is the fog computing platform developed by the [FogGuru European project](http://fogguru.eu). It allows users to connect IoT devices using the LoRa long-distance wireless protocol to local clusters of Raspberry PIs where data can be processed.

- Long-distance communication with your IoT devices thanks to the LoRa wireless protocol
- Local data processing enables real-time responses
- Reduced network usage compared to a traditional IoT/Cloud system
- The system keeps working even during network outages
- Attractive application development thanks to NodeRed
- Easy deployment of arbitrary software thanks to Kubernetes
- Fully open architecture

For more information please visit [http://www.fogguru.eu/livingfog/](http://www.fogguru.eu/livingfog/)

# kube-deploy-lora
### Preparing the Raspberry Pis for running ansible

Run etcher from cli to burn images:
```
$ sudo /Applications/balenaEtcher.app/Contents/MacOS/balenaEtcher
```

Allow ssh in SD cards
```
$ touch /Volumes/boot/ssh
```

SSH into each Pis
```
$ ssh pi@raspberrypi.local
```

Add the following text inside the file `/boot/cmdline.txt`
```
cgroup_enable=memory
```

Update the `/etc/network/interfaces` file for setting specific IP address
```
auto eth0
iface eth0 inet static
address 192.168.1.10
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameservers 192.168.1.1 8.8.8.8
```

Update the `/etc/hosts` with your cluster's of IP addresses
```
192.168.1.10 pc0
192.168.1.11 pc1
192.168.1.12 pc2
...
192.168.1.N pcN
```

Edit the hostname and password by editing `raspi-config`
```
$ sudo raspi-config
```

Reboot
```
$ sudo reboot
```

Lastly, enable passwordless connection by from your machine by copying 
```
$ ssh-copy-id pi@name
```

### The Pi is now ready to run ansible scripts
