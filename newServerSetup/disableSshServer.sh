#!/bin/bash

# Check if the script is run with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script with sudo or as root."
    exit 1
fi

# Stop SSH server
echo "Stopping SSH server..."
systemctl stop ssh

# Disable SSH server from starting on boot
echo "Disabling SSH server from starting on boot..."
systemctl disable ssh

# Print status
echo "SSH server disabled."

