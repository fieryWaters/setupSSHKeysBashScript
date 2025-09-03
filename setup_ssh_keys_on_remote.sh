#!/bin/bash

echo "Welcome to my dope SSH server setup script!"

# Function to generate SSH key
generate_ssh_key() {
    echo "Enter a name for the key file"
    read -r keyName
    identityFileLocation="$HOME/.ssh/$keyName"
    ssh-keygen -t rsa -N "" -f "$identityFileLocation"
}

# Function to send public key to remote host's authorized_keys
send_public_key() {
    echo "Enter the Username for the remote host"
    read -r remoteUser
    echo "Enter the IP Address for the remote host"
    read -r remoteIpAddress

    qcat "$HOME/.ssh/$keyName.pub" | ssh "$remoteUser@$remoteIpAddress" "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
}

# Function to set up local config file
setup_local_config_file() {
    configFile="$HOME/.ssh/config"
    {
        echo ""
        echo "Host $keyName $remoteIpAddress"
        echo -e "\tHostName $remoteIpAddress"
        echo -e "\tIdentityFile $identityFileLocation"
        echo -e "\tUser $remoteUser"
        echo ""
    } >>"$configFile"
}

# Function to test SSH connection with key authentication
test_ssh_connection() {
    echo "If connection below succeeds, ssh key authentication was successful"
    ssh "$keyName" "echo ssh key authentication is successful"
}


# Main function
main() {
    generate_ssh_key
    send_public_key
    setup_local_config_file
    test_ssh_connection
}

# Execute the main function
main
