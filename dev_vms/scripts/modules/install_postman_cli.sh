#!/bin/bash

# Idempotent install script for Postman CLI (Newman)

# Log the installation start
echo "Installing Postman CLI (Newman)..."

# Ensure npm is installed (necessary to install Newman)
if ! command -v npm &> /dev/null; then
    echo "npm is required but not found. Installing npm..."
    sudo apt-get update -y
    sudo apt-get install -y npm
fi

# Check if Newman is already installed
if ! command -v newman &> /dev/null; then
    # Install Newman globally using npm if not installed
    sudo npm install -g newman
    echo "Postman CLI (Newman) installed successfully."
else
    echo "Postman CLI (Newman) is already installed. Skipping installation."
fi

# Confirm installation
newman --version