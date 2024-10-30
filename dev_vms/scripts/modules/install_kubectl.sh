#!/bin/bash

# Idempotent script to install kubectl

# Log the installation start
echo "Installing kubectl..."

# Define the path for the GPG key and the Kubernetes repository list file
KEYRING_PATH="/usr/share/keyrings/kubernetes-archive-keyring.gpg"
REPO_LIST_PATH="/etc/apt/sources.list.d/kubernetes.list"

# Check if the Google Cloud public signing key is already added, add it if missing
if [ ! -f "$KEYRING_PATH" ]; then
    echo "Adding the Google Cloud public signing key..."
    curl -fsSLo "$KEYRING_PATH" https://packages.cloud.google.com/apt/doc/apt-key.gpg
else
    echo "Google Cloud public signing key is already present. Skipping."
fi

# Check if the Kubernetes repository is already added, add it if missing
if [ ! -f "$REPO_LIST_PATH" ]; then
    echo "Adding the Kubernetes apt repository..."
    echo "deb [signed-by=$KEYRING_PATH] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee "$REPO_LIST_PATH" > /dev/null
else
    echo "Kubernetes apt repository is already added. Skipping."
fi

# Install kubectl if it is not already installed
if ! command -v kubectl &> /dev/null; then
    echo "Updating package list and installing kubectl..."
    sudo apt-get update -y
    sudo apt-get install -y kubectl
    echo "kubectl installed successfully."
else
    echo "kubectl is already installed. Skipping installation."
fi

# Confirm installation
kubectl version --client
