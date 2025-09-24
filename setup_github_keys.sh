#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0"
    echo "Please provide the following information:"
    echo "1. GitHub username"
    echo "2. GitHub email"
    echo "3. (Optional) Filename for the SSH key (default is id_rsa)"
    exit 1
}

# Prompt for GitHub username
read -p "Enter your GitHub username: " github_username

# Prompt for GitHub email
read -p "Enter your GitHub email: " github_email

#key filename MUST be id_rsa for github!
key_filename=id_rsa

# Step 1: Generate SSH key pair
echo "Generating SSH key pair..."
ssh-keygen -t rsa -b 4096 -C "$github_email" -f ~/.ssh/"$key_filename"

# Step 2: Add SSH key to GitHub account
echo "Please copy the following SSH key and add it to your GitHub account:"
cat ~/.ssh/"$key_filename".pub

read -p "Press Enter to continue after adding the SSH key to your GitHub account..."

# Step 3: Set Git user email and name
git config --global user.email "$github_email"
git config --global user.name "$github_username"

# Step 4: Test SSH connection to GitHub
echo "Testing SSH connection to GitHub..."
ssh -T git@github.com

