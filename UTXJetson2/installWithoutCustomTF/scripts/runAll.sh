#!/bin/bash

echo "Running all the installation scripts."

SCRIPT_DIR=$(dirname "$BASH_SOURCE")

echo "Running \`dpkg --configure -a\` in case dpkg was interrupted before..."
dpkg --configure -a

echo "Setting up SSH..."
"$SCRIPT_DIR/setUpSSH.sh"
if [[ "$1" -eq 1 ]]; then
    echo "Setting up NFS (server)..."
    "$SCRIPT_DIR/setUpNFSServer.sh"
fi
echo "Setting up NFS (client)..."
"$SCRIPT_DIR/setUpNFSClient.sh" $1
echo "Installing CUDA..."
"$SCRIPT_DIR/installCUDA.sh"
echo "Installing TensorFlow..."
"$SCRIPT_DIR/tf-1.3_quick_install.sh"
echo "Misc configuration..."
"$SCRIPT_DIR/miscConfig.sh" $2