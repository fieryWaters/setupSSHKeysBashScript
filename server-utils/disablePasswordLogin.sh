#!/bin/bash

# Function to check if the script is run with sudo
check_sudo() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Please run this script with sudo or as root."
        exit 1
    fi
}

# Function to disable password login
disable_password_login() {
    echo "Disabling password login..."
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    systemctl restart ssh
    echo "Password login disabled."
}

# Main function
main() {
    check_sudo
    disable_password_login
}

# Execute the main function
main
