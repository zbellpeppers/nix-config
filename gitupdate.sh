#!/usr/bin/env bash

set -e

CURRENT_USER=$(logname || whoami)

# Define valid rebuild commands
valid_commands=("switch" "boot" "test" "build" "dry-activate" "build-vm" "build-vm-with-bootloader" "dry-build" "edit" "build-image")

# Define commands that will skip the git process
skip_git_commands=("test" "build" "dry-activate" "dry-build" "build-vm" "build-vm-with-bootloader" "build-image" "edit")

# Function to display usage
show_usage() {
    echo "Usage: $0 [command] [flags...]"
    echo "Valid commands: ${valid_commands[*]}"
    echo "Examples:"
    echo "  $0 switch"
    echo "  $0 build-image --image-variant iso"
}

# Function to restore backup on failure
restore_backup() {
    echo "Restoring backup from $backup_dir"
    sudo rm -rf /etc/nixos
    sudo cp -r "$backup_dir/nixos" /etc/nixos
    sudo rm -rf "$backup_dir"
}

# Parse command-line arguments
if [ $# -eq 0 ]; then
    rebuild_command="switch"
    rebuild_args=()
else
    rebuild_command="$1"
    shift  # Remove the first argument
    rebuild_args=("$@")  # Capture all remaining arguments
fi

# Validate the rebuild command
if [[ ! " ${valid_commands[*]} " =~ " ${rebuild_command} " ]]; then
    echo "Error: Invalid rebuild command: $rebuild_command"
    show_usage
    exit 1
fi

# Check if we should skip git operations
if [[ " ${skip_git_commands[*]} " =~ " ${rebuild_command} " ]]; then
    echo "Command '$rebuild_command' detected. Will skip git operations."
    commit_message=""
    skip_git=true
else
    # Ask user for a commit message at the beginning
    echo "Enter a commit message (or press Enter for default message):"
    read user_message
    
    # Use default message if user didn't provide one
    if [ -z "$user_message" ]; then
        build_id=$(date +"%Y%m%d-%H%M%S")
        commit_message="nixos - build #$build_id"
    else
        commit_message="$user_message"
    fi
    skip_git=false
fi

# Create a temporary backup directory
backup_dir=$(mktemp -d)
echo "Creating backup of /etc/nixos in $backup_dir"
sudo cp -r /etc/nixos "$backup_dir"

# Sync files from ~/nix-config to /etc/nixos
echo "Syncing files from ~/nix-config to /etc/nixos"
sudo rsync -a --delete --exclude='.git' ~/nix-config/ /etc/nixos/

# Perform the rebuild
if [ ${#rebuild_args[@]} -eq 0 ]; then
    echo "Starting NixOS rebuild with command: $rebuild_command"
    rebuild_cmd=("sudo" "nixos-rebuild" "$rebuild_command")
else
    echo "Starting NixOS rebuild with command: $rebuild_command ${rebuild_args[*]}"
    rebuild_cmd=("sudo" "nixos-rebuild" "$rebuild_command" "${rebuild_args[@]}")
fi

cd /etc/nixos

# Run the rebuild with all arguments
if "${rebuild_cmd[@]}"; then
    rebuild_success=true
    echo "NixOS rebuild completed successfully."
else
    rebuild_success=false
    echo "NixOS rebuild failed."
fi

# Handle success/failure
if [ "$rebuild_success" = true ]; then
    # Update flake.lock in the git repo if it exists in /etc/nixos
    if [ -f /etc/nixos/flake.lock ]; then
        echo "Updating flake.lock in git repository"
        # Remove the old flake.lock if it exists
        [ -f ~/nix-config/flake.lock ] && sudo rm ~/nix-config/flake.lock
        # Copy the new flake.lock and set proper ownership
        sudo cp /etc/nixos/flake.lock ~/nix-config/
        sudo chown "$CURRENT_USER" ~/nix-config/flake.lock
    fi
    
    # Change ownership of /etc/nixos files to root
    sudo chown -R root:root /etc/nixos
    echo "Changed ownership of /etc/nixos files to root."

    # Clean up the backup
    sudo rm -rf "$backup_dir"
    
    # Handle git operations based on command type
    if [ "$skip_git" = true ]; then
        echo "Command '$rebuild_command' completed. Skipping git operations as planned."
        exit 0
    fi

    # Change to the nix-config directory for git operations
    cd ~/nix-config

    # Perform Git operations
    echo "Performing git operations..."
    git add .
    echo "Using commit message: $commit_message"
    git commit -m "$commit_message"
    git push

    echo "Changes committed and pushed to Git repository."
else
    restore_backup
    exit 1
fi
