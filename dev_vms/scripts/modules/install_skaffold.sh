#!/bin/bash

# Idempotent install script for Skaffold

# Log the installation start
echo "Installing Skaffold..."

# Define the installation path
INSTALL_PATH="/usr/local/bin/skaffold"

# Get the latest Skaffold version from GitHub
LATEST_VERSION=$(curl -s "https://api.github.com/repos/GoogleContainerTools/skaffold/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')

# Check if Skaffold is already installed and up-to-date
if command -v skaffold &> /dev/null && [[ "$(skaffold version --output json | jq -r .version)" == "$LATEST_VERSION" ]]; then
    echo "Skaffold $LATEST_VERSION is already installed. Skipping installation."
else
    echo "Downloading Skaffold version $LATEST_VERSION..."
    curl -Lo skaffold "https://storage.googleapis.com/skaffold/releases/$LATEST_VERSION/skaffold-linux-amd64"

    # Install Skaffold
    sudo install skaffold "$INSTALL_PATH"
    rm skaffold

    echo "Skaffold $LATEST_VERSION installed successfully."
fi

# Confirm installation
skaffold version
