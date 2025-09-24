#!/bin/bash

# Function to enable password authentication
enable_password_authentication() {
    echo "Enabling password authentication..."
    sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart ssh
    echo "Password authentication enabled."
}

# Execute the function to enable password authentication
enable_password_authentication

