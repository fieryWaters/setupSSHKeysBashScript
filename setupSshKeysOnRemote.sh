#!/bin/bash

echo "Welcome to my dope SSH server setup script!"

# Function to prompt the user to disable password login
prompt_disable_password_login() {
    echo "It's recommended to disable password login for security reasons."
    read -r -p "Would you like to disable password login? (yes/no): " disable_password
    if [[ $disable_password =~ ^[Yy](es)?$ ]]; then
        return 0
    else
        return 1
    fi
}

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

    cat "$HOME/.ssh/$keyName.pub" | ssh "$remoteUser@$remoteIpAddress" "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
}

# # Function to prompt user for remote port
# prompt_remote_port() {
#     echo "What port would you configure the remote server to use?"
#     read -r remotePort
#     echo "Did you type it right? [yes, y] to continue "
#     read -r verify
#     while [[ $verify != 'yes' ]] && [[ $verify != 'y' ]]; do
#         read -r -p "Did you type it right? [yes, y] to continue " verify
#     done
# }

# Function to configure remote server
configure_remote_server() {
    echo "Disabling password login"
    
    if prompt_disable_password_login; then
        echo "Disabling password login..."
        ssh -t "$remoteUser@$remoteIpAddress" "sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config"
    else
        echo "Password login not disabled."
    fi
    
    
    echo "Restarting SSH service..."
    ssh -t "$remoteUser@$remoteIpAddress" "sudo systemctl restart sshd"
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

# Function to prompt the user to create a stronger password
prompt_create_stronger_password() {
    echo "Your current password might not be strong enough."
    read -r -p "Would you like to create a stronger password? (yes/no): " stronger_password
    if [[ $stronger_password =~ ^[Yy](es)?$ ]]; then
        ssh "$remoteUser@$remoteIpAddress" 'passwd'
    fi
}

# Main function
main() {
    generate_ssh_key
    send_public_key
    #configure_remote_server
    setup_local_config_file
    test_ssh_connection
    prompt_create_stronger_password
}

# Execute the main function
main
