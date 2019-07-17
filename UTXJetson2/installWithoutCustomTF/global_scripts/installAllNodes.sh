#!/bin/bash

# This script must be run in the parent directory of the "scripts" directory.
# Install sshpass before you run it.

function isIn () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

IP_ADDRESSES_FILE="$(dirname $BASH_SOURCE)/node_ip_addresses.txt"
USERNAME="nvidia"
SUDO_PW="nvidia"
NEW_USERNAME='mpiuser'
NEW_PW='mpiuser'
LOG_DIR="logs"

function setUpUserOnNode () {
    ip_addr=$1
    LOGFILE="$LOG_DIR/log_$ip_addr.txt"
    hostname="$USERNAME@$ip_addr"
    echo "Creating new user on $hostname..." > "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh "$hostname" "echo '$SUDO_PW' | sudo -HS useradd -m '$NEW_USERNAME'" >> "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh "$hostname" "echo '$SUDO_PW' | sudo -HS adduser '$NEW_USERNAME' sudo" >> "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh "$hostname" "echo '$SUDO_PW' | sudo -HS bash -c \"echo '$NEW_USERNAME:$NEW_PW' | chpasswd\"" >> "$LOGFILE" 2>&1
}

function installNode () {
    ip_addr=$1
    LOGFILE="$LOG_DIR/log_$ip_addr.txt"
    hostname="$USERNAME@$ip_addr"
    echo "Copying scripts to host $hostname..." >> "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" scp -o StrictHostKeyChecking=accept-new -r scripts/ node_ip_addresses.txt "$hostname": >> "$LOGFILE" 2>&1
    echo "Installing on host $hostname..." >> "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh "$hostname" "echo '$SUDO_PW' | sudo -HS bash scripts/runAll.sh $2" >> "$LOGFILE" 2>&1
}

mkdir -p "$LOG_DIR"

while read ip_addr; do
    setUpUserOnNode $ip_addr &
done < "$IP_ADDRESSES_FILE"

MASTER_IDs=(7 15 23)
i=0
while read ip_addr; do
    if [[ $(isIn $i MASTER_IDs) ]]: then
        isMaster=true
    else
        isMaster=false
    fi
    installNode $ip_addr $isMaster &
done < "$IP_ADDRESSES_FILE"

wait

echo "Done!"