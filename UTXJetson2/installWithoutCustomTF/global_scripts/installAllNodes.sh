#!/bin/bash

# This script must be run in the parent directory of the "scripts" directory.
# Install sshpass before you run it.

IP_ADDRESSES_FILE="$(dirname $BASH_SOURCE)/node_ip_addresses.txt"
USERNAME="nvidia"
SUDO_PW="nvidia"
LOG_DIR="logs"

function installNode () {
    ip_addr=$1
    LOGFILE="$LOG_DIR/log_$ip_addr.txt"
    hostname="$USERNAME@$ip_addr"
    echo "Copying scripts to node n°$i..." > "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" scp -o StrictHostKeyChecking=accept-new -r scripts/ "$hostname": > "$LOGFILE" 2>&1
    echo "Installing on node n°$i..." > "$LOGFILE" 2>&1
    sshpass -p "$SUDO_PW" ssh "$hostname" "echo '$SUDO_PW' | sudo -S bash scripts/runAll.sh" > "$LOGFILE" 2>&1
}

mkdir -p "$LOG_DIR"

while read ip_addr; do
    installNode $ip_addr &
done < "$IP_ADDRESSES_FILE"

wait

echo "Done!"