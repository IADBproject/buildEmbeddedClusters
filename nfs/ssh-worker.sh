#!/bin/bash

## Parameters from nfs-addworker.shh
WorkerHost=$1		#"xxx.xxx.xxx.xxx"
WorkerName=$2		#"username"
WorkerNewName=$3	#"newusername"

echo "Enable secure communication between the master and worker"

##1) Created newly account
ssh -t $WorkerName@$WorkerHost "sudo useradd -m '$WorkerNewName'"
ssh -t $WorkerName@$WorkerHost "sudo passwd '$WorkerNewName'"
##ssh -t WorkerName@$WorkerHost "sudo mkhomedir_helper '$WorkerNewName'"

##1.1) Add new user into sudoers
ssh -t $WorkerName@$WorkerHost "sudo adduser "$WorkerNewName" sudo"

##2) Copy the master key to the worker
ssh-copy-id -i ~/.ssh/id_rsa.pub $WorkerNewName@$WorkerHost

##2.1) Test the new key
ssh -i $WorkerNewName@$WorkerHost

##3) Generate an SSH Key on the worker
ssh -t $WorkerNewName@$WorkerHost "ssh-keygen"

##3.1) Copy the worker key to the master & add in authorized_keys
scp $WorkerNewName@$WorkerHost:~/.ssh/id_rsa.pub . 
cat id_rsa.pub >> ~/.ssh/authorized_keys 
rm id_rsa.pub

echo "Secure Comunication Enable"

