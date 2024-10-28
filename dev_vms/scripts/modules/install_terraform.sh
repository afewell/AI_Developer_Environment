#!/bin/bash

# Idempotent script to install Terraform

# Log the installation start
echo "Installing Terraform..."

# Define the HashiCorp GPG key path and repository file path
KEYRING_PATH="/usr/share/keyrings/hashicorp-archive-keyring.gpg"
REPO_LIST_PATH="/etc/apt/sources.list.d/hashicorp.list"

# Add the HashiCorp GPG key if not already added
if [ ! -f "$KEYRING_PATH" ]; then
    echo "Adding HashiCorp GPG key..."
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo tee "$KEYRING_PATH" > /dev/null
else
    echo "HashiCorp GPG key is already present. Skipping."
fi

# Add the HashiCorp repository if not already added
if [ ! -f "$REPO_LIST_PATH" ]; then
    echo "Adding HashiCorp repository..."
    echo "deb [signed-by=$KEYRING_PATH] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee "$REPO_LIST_PATH" > /dev/null
else
    echo "HashiCorp repository is already added. Skipping."
fi

# Install Terraform if not already installed
if ! command -v terraform &> /dev/null; then
    echo "Updating package list and installing Terraform..."
    sudo apt-get update -y
    sudo apt-get install -y terraform
    echo "Terraform installed successfully."
else
    echo "Terraform is already installed. Skipping installation."
fi

# Confirm installation
terraform -version