#!/bin/bash

# Log the installation start
echo "Installing LocalTunnel..."

# Ensure npm is installed (necessary to install LocalTunnel)
if ! command -v npm &> /dev/null; then
    echo "npm is required but not found. Installing npm..."
    sudo apt-get update -y
    sudo apt-get install -y npm
else
    echo "npm is already installed. Skipping npm installation."
fi

# Install LocalTunnel globally using npm if not already installed
if ! npm list -g localtunnel &> /dev/null; then
    echo "Installing LocalTunnel globally using npm..."
    sudo npm install -g localtunnel
    echo "LocalTunnel installed successfully."
else
    echo "LocalTunnel is already installed globally. Skipping installation."
fi

# Confirm installation by showing the LocalTunnel version
lt --help
