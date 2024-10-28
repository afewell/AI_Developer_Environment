#!/bin/bash

# Install script for dev_container_host-1

# Function to log messages with timestamps
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# Update package list
log "Updating package list..."
sudo apt-get update -y

# Pre-app-install-hook
## Execute any scripts here that should run prior to app installation
./modules/config_passwordless_sudo.sh

# Install Apps with simple 1-line apt install
## Define list of apps
simple_apt_installs=(
    curl
    git
    jq
    htop
    tree
    make
    tmux
    net-tools
    iftop
    dstat
    iotop
    ncdu
    python3
    python3-pip
    python3-venv
    npm
    nodejs
    golang
    httpie
    rsync
)
## Execute installation of 1-line apt packages
log "Installing 1-line apt packages..."
sudo apt-get install -y "${simple_apt_installs[@]}"

# Execute all module scripts for additional packages

# Run each module script directly since each script is already idempotent
declare -a install_scripts=(
    "install_docker.sh"
    "install_helm.sh"
    "install_k9s.sh"
    "install_kubectl.sh"
    "install_localtunnel.sh"
    "install_minikube.sh"
    "install_postman_cli.sh"
    "install_skaffold.sh"
    "install_terraform.sh"
    "install_vscode.sh"
    "install_vscode_extensions.sh"
)

for script in "${install_scripts[@]}"; do
    log "Running $script..."
    ./modules/$script
done

log "Setup complete."