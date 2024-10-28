#!/bin/bash

# Idempotent script to install helm

# Log the installation start
echo "Installing Helm..."

# Check if the Helm GPG key is already added
if ! apt-key list | grep -q "Helm Stable"; then
    echo "Adding Helm GPG key..."
    curl -fsSL https://baltocdn.com/helm/signing.asc | sudo apt-key add -
else
    echo "Helm GPG key is already added. Skipping."
fi

# Check if the Helm repository is already added
if ! grep -q "^deb .*/helm/stable/debian/" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    echo "Adding Helm apt repository..."
    sudo apt-add-repository -y "deb https://baltocdn.com/helm/stable/debian/ all main"
else
    echo "Helm apt repository is already added. Skipping."
fi

# Update package list and install Helm if not already installed
if ! command -v helm &> /dev/null; then
    echo "Updating package list and installing Helm..."
    sudo apt-get update -y
    sudo apt-get install -y helm
    echo "Helm installed successfully."
else
    echo "Helm is already installed. Skipping installation."
fi

# Confirm installation
helm version
