#!/bin/bash

## Parameters from nfs-addworker.shh
WorkerHost=$1		#"xxx.xxx.xxx.xxx"
WorkerHostName=$2	#"hostname"
WorkerNewName=$3	#"newusername"

echo "-- Add worker into the master NFS --"

##1) Add the worker ip-host into the master
echo "$WorkerHost $WorkerHostName" | sudo tee -a /etc/hosts

##2) Add the worker ip-host into the share folder 
echo "/home/$WorkerNewName/cloud "$WorkerHost"(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports

##3) Update the environment
sudo exportfs -a

##4) Restart the nfs server
sudo service nfs-kernel-server restart
