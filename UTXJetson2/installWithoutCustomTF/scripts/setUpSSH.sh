#!/bin/bash

IP_ADDRESSES_FILE="$(dirname $BASH_SOURCE)/../node_ip_addresses.txt"
USERNAME='mpiuser'
PW='mpiuser'

apt-get install -y sshpass

# generate this node's SSH key
su mpiuser -c 'mkdir -p /home/mpiuser/.ssh && ssh-keygen -t rsa -N "" -f "/home/mpiuser/.ssh/id_rsa"'

# copy the key to all nodes
while read ip_addr; do
    hostname="$USERNAME@$ip_addr"
    echo "Copying SSH key to $hostname..."
    sshpass -p "$PW" ssh-copy-id -o StrictHostKeyChecking=no -i /home/mpiuser/.ssh/id_rsa "$hostname"
done < "$IP_ADDRESSES_FILE"