#!/bin/bash

WorkerHost="xxx.xxx.xxx.xxx"
WorkerHostName="hostname"
WorkerName="username"
WorkerNewName="newusername"
MasterHost="xxx.xxx.xxx.xxx"
MasterHostName="hostname"
MasterName="username"


## Enable secure communication between the master and worker
./ssh-worker.sh $WorkerHost $WorkerName $WorkerNewName

## Add worker into the master NFS
./nfs-master.sh $WorkerHost $WorkerHostName $WorkerNewName

## Mount the NFS shared directory into the worker
./nfs-worker.sh $WorkerHost $WorkerHostName $WorkerNewName $MasterHost $MasterName $MasterHostName


