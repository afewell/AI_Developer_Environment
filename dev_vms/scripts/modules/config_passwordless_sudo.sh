#!/bin/bash

# Idempotent script to configure passwordless sudo

# Get the original user, even if the script is run with sudo
current_user="${SUDO_USER:-$(whoami)}"

# Define the sudoers entry for passwordless sudo
sudoers_entry="$current_user ALL=(ALL) NOPASSWD:ALL"

# Check if the entry already exists in /etc/sudoers
if sudo grep -Fxq "$sudoers_entry" /etc/sudoers; then
    echo "Passwordless sudo is already enabled for $current_user. No changes made."
else
    # Add the user to the sudoers file for passwordless sudo
    echo "$sudoers_entry" | sudo EDITOR='tee -a' visudo
    echo "Passwordless sudo privileges granted to $current_user."
fi

