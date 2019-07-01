#!/bin/bash

WorkerHost=$1		#"xxx.xxx.xxx.xxx"
WorkerHostName=$2       #"hostname"
WorkerNewName=$3	#"newusername"
MasterHost=$4		#"xxx.xxx.xxx.xxx"
MasterHostName=$6	#"hostname"
MasterName=$5           #"username"

echo "Mount the NFS shared directory into the worker"

##1) Install nfs on the worker
ssh -t $WorkerNewName@$WorkerHost "sudo apt-get install nfs-common"

##2) Add the worker and master public-ips
ssh -t $WorkerNewName@$WorkerHost "echo \"$WorkerHost $WorkerHostName\" | sudo tee -a /etc/hosts"
ssh -t $WorkerNewName@$WorkerHost "echo \"$MasterHost $MasterHostName\" | sudo tee -a /etc/hosts"

##3) Create a directory in the worker
ssh -t $WorkerNewName@$WorkerHost "mkdir ~/cloud"

##4) Mount the shared directory
ssh -t $WorkerNewName@$WorkerHost "sudo mount -t nfs $MasterHost:/home/mpiuser/cloud ~/cloud"

##5) check the mounted directories
ssh -t $WorkerNewName@$WorkerHost "df -h"

##6) Mount the shared directory permanent 
ssh -t $WorkerNewName@$WorkerHost "echo \"$MasterHost:/home/$MasterName/cloud /home/$WorkerName/cloud nfs\" | sudo tee -a /etc/fstab"

## Check the mount permanent
ssh -t $WorkerNewName@$WorkerHost "cat /etc/fstab"

echo "NFS mounted"
