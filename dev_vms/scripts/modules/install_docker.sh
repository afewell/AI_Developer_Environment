#!/bin/bash

# Idempotent script to install docker, docker cli, containerd, docker-compose & configure sudoless docker

# Get the current user, even if the script is run with sudo
current_user="${SUDO_USER:-$(whoami)}"

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    echo "Docker installed successfully."
}

# Function to install Docker Compose
install_docker_compose() {
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose installed successfully."
}

# Check if Docker is already installed and install if necessary
if ! command -v docker &> /dev/null; then
    install_docker
else
    echo "Docker is already installed. Skipping Docker installation."
fi

# Check if Docker Compose is already installed and install if necessary
if ! command -v docker-compose &> /dev/null; then
    install_docker_compose
else
    echo "Docker Compose is already installed. Skipping Docker Compose installation."
fi

# Add the current user to the docker group for sudoless Docker access, if not already added
if id -nG "$current_user" | grep -qw "docker"; then
    echo "User $current_user is already in the docker group. No changes made."
else
    echo "Adding user $current_user to the docker group for sudoless Docker access..."
    sudo usermod -aG docker "$current_user"
    echo "User $current_user added to the docker group. Please log out and log back in to enable sudoless Docker."
fi
