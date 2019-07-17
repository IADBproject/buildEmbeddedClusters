#!/bin/bash

MASTER_ADDRESSES_FILE="$(dirname $BASH_SOURCE)/../master_ip_addresses.txt"

apt-get install -y nfs-common

i=0
while read ip_addr; do
    mountpoint="/home/mpiuser/cloud/$i"
    mkdir -p "$mountpoint"
    mount -t nfs -o proto=tcp,port=2049 "$ip_addr:/exports" "$mountpoint"
    i=$(( i+1 ))
done < "$MASTER_ADDRESSES_FILE"
