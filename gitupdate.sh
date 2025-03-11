#!/usr/bin/env bash

set -e

# Define valid rebuild commands
valid_commands=("switch" "boot" "test" "build" "dry-activate" "build-vm" "build-vm-with-bootloader" "dry-build" "edit")

# Function to display usage
show_usage() {
    echo "Usage: $0 [command]"
    echo "Valid commands: ${valid_commands[*]}"
}

# Parse command-line argument
rebuild_type=${1:-switch}

# Validate the rebuild type
if [[ ! " ${valid_commands[*]} " =~ " ${rebuild_type} " ]]; then
    echo "Error: Invalid rebuild type: $rebuild_type"
    show_usage
    exit 1
fi

# Create a temporary backup directory
backup_dir=$(mktemp -d)
echo "Creating backup of /etc/nixos in $backup_dir"
sudo cp -r /etc/nixos "$backup_dir"

# Sync files from ~/nix-config to /etc/nixos
echo "Syncing files from ~/nix-config to /etc/nixos"
sudo rsync -a --delete --exclude='.git' ~/nix-config/ /etc/nixos/

# Perform the rebuild
echo "Starting NixOS rebuild with command: $rebuild_type"
cd /etc/nixos

# Check if it's a flake-based configuration
if [ -f flake.nix ]; then
    # Run the rebuild with flake
    if sudo nixos-rebuild "$rebuild_type" --flake .#; then
        rebuild_success=true
    else
        rebuild_success=false
    fi
else
    # Run the traditional rebuild
    if sudo nixos-rebuild "$rebuild_type"; then
        rebuild_success=true
    else
        rebuild_success=false
    fi
fi

if [ "$rebuild_success" = true ]; then
    echo "NixOS rebuild completed successfully."
    
    # Update flake.lock in the git repo if it exists in /etc/nixos
    if [ -f /etc/nixos/flake.lock ]; then
        echo "Updating flake.lock in git repository"
        # Remove the old flake.lock if it exists
        [ -f ~/nix-config/flake.lock ] && rm ~/nix-config/flake.lock
        # Copy the new flake.lock and set proper ownership
        sudo cp /etc/nixos/flake.lock ~/nix-config/
        sudo chown zachary ~/nix-config/flake.lock
    fi
    
    # Change ownership of /etc/nixos files to root
    sudo chown -R root:root /etc/nixos
    echo "Changed ownership of /etc/nixos files to root."

    # Clean up the backup
    sudo rm -rf "$backup_dir"
    
    # Skip git operations for test builds
    if [ "$rebuild_type" = "test" ]; then
        echo "Test build completed. Skipping git operations."
        exit 0
    fi

    # Change to the nix-config directory
    cd ~/nix-config

    # Generate build ID (using date and time)
    build_id=$(date +"%Y%m%d-%H%M%S")
    commit_message="nixos - build #$build_id"

    # Perform Git operations
    git add .
    echo "Using commit message: $commit_message"
    git commit -m "$commit_message"
    git push

    echo "Changes committed and pushed to Git repository."
else
    echo "NixOS rebuild failed. Restoring backup."
    sudo rm -rf /etc/nixos
    sudo cp -r "$backup_dir/nixos" /etc/nixos
    sudo rm -rf "$backup_dir"
    exit 1
fi
