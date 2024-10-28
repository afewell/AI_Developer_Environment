#!/bin/bash

# Idempotent script to install k9s

# Log the installation start
echo "Installing K9s..."

# Set the desired version of K9s by querying the latest release tag from GitHub
K9S_VERSION=$(curl -s "https://api.github.com/repos/derailed/k9s/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')

# Define the path where K9s will be installed
INSTALL_PATH="/usr/local/bin/k9s"

# Check if K9s is installed and if it's the latest version
if command -v k9s &> /dev/null && [[ "$(k9s version --short)" == "$K9S_VERSION" ]]; then
    echo "K9s $K9S_VERSION is already installed. Skipping installation."
else
    echo "Installing K9s version $K9S_VERSION..."

    # Download the K9s binary for Linux
    curl -Lo k9s.tar.gz "https://github.com/derailed/k9s/releases/download/$K9S_VERSION/k9s_Linux_amd64.tar.gz"

    # Extract the binary and move it to the installation path
    tar -xzf k9s.tar.gz k9s
    sudo mv k9s "$INSTALL_PATH"

    # Clean up
    rm k9s.tar.gz

    echo "K9s $K9S_VERSION installed successfully."
fi

# Confirm installation
k9s version
