
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

# Pull the latest changes from your GitLab repository
echo "Pulling latest changes from GitLab repository"
cd ~/nix-config
git pull

# Sync files from ~/nix-config to /etc/nixos
echo "Syncing files from ~/nix-config to /etc/nixos"
sudo rsync -a --delete --exclude='.git' ~/nix-config/ /etc/nixos/

# Perform the rebuild
echo "Starting NixOS rebuild with command: $rebuild_type"
cd /etc/nixos

# Check if it's a flake-based configuration
if [ -f flake.nix ]; then
    echo "Detected flake-based configuration"
    # Run the rebuild with flake
    if sudo nixos-rebuild "$rebuild_type" --flake .#queen; then
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
    
    # Change ownership of /etc/nixos files to root
    sudo chown -R root /etc/nixos
    echo "Changed ownership of /etc/nixos files to root."

    # Clean up the backup
    sudo rm -rf "$backup_dir"
    
    echo "System successfully updated from GitLab repository."
else
    echo "NixOS rebuild failed. Restoring backup."
    sudo rm -rf /etc/nixos
    sudo cp -r "$backup_dir/nixos" /etc/nixos
    sudo rm -rf "$backup_dir"
    exit 1
fi
