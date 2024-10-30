#!/bin/bash

# Idempotent script to install VSCode

# Log the installation start
echo "Installing VSCode..."

# Define the GPG key path and repository file path for VSCode
KEYRING_PATH="/usr/share/keyrings/packages.microsoft.gpg"
REPO_LIST_PATH="/etc/apt/sources.list.d/vscode.list"

# Add the Microsoft GPG key if not already added
if [ ! -f "$KEYRING_PATH" ]; then
    echo "Adding Microsoft GPG key..."
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee "$KEYRING_PATH" > /dev/null
else
    echo "Microsoft GPG key is already present. Skipping."
fi

# Add the VSCode repository if not already added
if [ ! -f "$REPO_LIST_PATH" ]; then
    echo "Adding VSCode repository..."
    echo "deb [arch=amd64,arm64,armhf signed-by=$KEYRING_PATH] https://packages.microsoft.com/repos/code stable main" | sudo tee "$REPO_LIST_PATH" > /dev/null
else
    echo "VSCode repository is already added. Skipping."
fi

# Install VSCode if not already installed
if ! command -v code &> /dev/null; then
    echo "Updating package list and installing VSCode..."
    sudo apt-get update -y
    sudo apt-get install -y code
    echo "VSCode installed successfully."
else
    echo "VSCode is already installed. Skipping installation."
fi

# Confirm installation
code --version
