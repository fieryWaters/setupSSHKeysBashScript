#!/bin/bash

# Check if user is root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root or with sudo"
    exit 1
fi

# Install OpenSSH server if not already installed
echo "Installing OpenSSH server..."
apt-get update
apt-get install -y openssh-server

# Start the SSH server
echo "Starting SSH server..."
systemctl start ssh

# Enable SSH server to start on boot
echo "Enabling SSH server to start on boot..."
systemctl enable ssh

# Print status
echo "SSH server setup complete."

