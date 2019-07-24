#!/usr/bin/env python3

"""Run a command as root on all nodes."""

import paramiko

import os
import sys

IP_FILE = os.path.join(os.path.dirname(__file__), "node_ip_addresses.txt")
USERNAME = "mpiuser"
PASSWORD = "mpiuser"

with open(IP_FILE, "rt") as ipf:
    while True:
        line = ipf.readline()
        if line == "":
            break
        line = line.rstrip()
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.client.AutoAddPolicy)
        client.connect(
                hostname = line,
                port = 22,
                username = USERNAME,
                password = PASSWORD
        )
        command = "echo '{}' | sudo -HS bash -c '{}'".format(PASSWORD, ' '.join(sys.argv[1:]))
        print("Launching command '{}' on host {}...".format(command, line))
        stdin, stderr, stdout = client.exec_command(command)
