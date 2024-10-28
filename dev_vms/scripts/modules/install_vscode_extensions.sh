#!/bin/bash

# Idempotent script to install vscode extensions

# Log the installation start
echo "Installing VSCode extensions..."

# Function to check and install a VSCode extension if it's not already installed
install_extension() {
    local extension=$1
    if code --list-extensions | grep -q "$extension"; then
        echo "Extension $extension is already installed. Skipping."
    else
        echo "Installing extension $extension..."
        code --install-extension "$extension"
    fi
}

# Install desired extensions
install_extension ms-azuretools.vscode-docker
install_extension ms-vscode-remote.remote-containers

echo "VSCode extensions installed successfully."
