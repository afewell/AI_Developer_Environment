#!/bin/bash

# Idempotent script to install minikube

# Log the installation start
echo "Installing Minikube..."

# Define the Minikube installation path
INSTALL_PATH="/usr/local/bin/minikube"

# Fetch the latest version number of Minikube from GitHub
LATEST_VERSION=$(curl -s https://api.github.com/repos/kubernetes/minikube/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

# Check if Minikube is already installed and up-to-date
if command -v minikube &> /dev/null && [[ "$(minikube version --short | awk '{print $3}')" == "$LATEST_VERSION" ]]; then
    echo "Minikube $LATEST_VERSION is already installed. Skipping installation."
else
    # Download the latest Minikube binary
    echo "Downloading Minikube version $LATEST_VERSION..."
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/$LATEST_VERSION/minikube-linux-amd64

    # Install Minikube
    sudo install minikube "$INSTALL_PATH"
    rm minikube

    echo "Minikube $LATEST_VERSION installed successfully."
fi

# Confirm installation
minikube version
