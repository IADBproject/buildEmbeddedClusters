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
MASTER_IP_ADDRESSES_FILE="$(dirname $BASH_SOURCE)/master_ip_addresses.txt"
USERNAME="nvidia"
SUDO_PW="nvidia"
NEW_USERNAME='mpiuser'
NEW_PW='mpiuser'
LOG_DIR="logs"

function getHostname () {
    hostname="$USERNAME@$1"
    echo "$hostname"
}

function getLogFile () {
    echo "$LOG_DIR/log_$1.txt"
}

function setUpUserOnNode () {
    ip_addr=$1
    LOGFILE=$(getLogFile $ip_addr)
    hostname=$(getHostname $ip_addr)
    echo "Creating new user on $hostname..." > "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh -o StrictHostKeyChecking=accept-new "$hostname" "echo '$SUDO_PW' | sudo -HS useradd -m '$NEW_USERNAME'" >> "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh "$hostname" "echo '$SUDO_PW' | sudo -HS adduser '$NEW_USERNAME' sudo" >> "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh "$hostname" "echo '$SUDO_PW' | sudo -HS bash -c \"echo '$NEW_USERNAME:$NEW_PW' | chpasswd\"" >> "$LOGFILE" 2>&1
}

function sendScriptsToNode () {
    ip_addr=$1
    LOGFILE=$(getLogFile $ip_addr)
    hostname=$(getHostname $1)
    echo "Copying scripts to host $hostname..." >> "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" scp -o StrictHostKeyChecking=accept-new -r scripts/ "$IP_ADDRESSES_FILE" "$MASTER_IP_ADDRESSES_FILE" "$hostname": >> "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh "$hostname" "chmod +x scripts/*.sh" scripts/ >> "$LOGFILE" 2>&1
}

function installNode () {
    ip_addr=$1
    LOGFILE=$(getLogFile $ip_addr)
    hostname="$USERNAME@$ip_addr"

    sendScriptsToNode $ip_addr

    echo "Installing on host $hostname..." >> "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh "$hostname" "echo '$SUDO_PW' | sudo -HS bash scripts/runAll.sh $2" >> "$LOGFILE" 2>&1
}

mkdir -p "$LOG_DIR"

echo "Setting up user $NEW_USERNAME..."
while read ip_addr; do
    setUpUserOnNode $ip_addr &
done < "$IP_ADDRESSES_FILE"

wait

USERNAME="$NEW_USERNAME"
SUDO_PW="$NEW_PW"

# first install the NFS masters
echo "Setting up the NFS masters..."
while read ip_addr; do
    installNode $ip_addr 1 &
done < "$MASTER_IP_ADDRESSES_FILE"

wait

# then install the other nodes
echo "Setting up the workers..."
while read ip_addr; do
    isMaster=0
    while read master_addr; do
        if [[ "$ip_addr" == "$master_addr" ]]; then
            isMaster=1
        fi
    done < "$MASTER_IP_ADDRESSES_FILE"
    if [[ "$isMaster" == 0 ]]; then
        installNode $ip_addr 0 &
    fi
done < "$IP_ADDRESSES_FILE"

wait

echo "Done!"