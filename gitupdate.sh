
#!/bin/bash

# Exit Immediately if any command fails
set -e

# Get the current user
current_user=$(whoami)

# Define directories
config_dir="/home/$current_user/nix-config"
nixos_dir="/etc/nixos"
backup_dir=$(mktemp -d)

# Backup existing /etc/nixos
sudo cp -r "$nixos_dir" "$backup_dir"
echo "NixOS Configuration backed up to: $backup_dir."

# Remove existing files in /etc/nixos
sudo rm -rf "$nixos_dir/"*

# Copy files from ~/nix-config to /etc/nixos
sudo cp -r "$config_dir/"* "$nixos_dir/" || { echo "Copy failed"; exit 1; }

# Attempt to rebuild the system
if sudo nixos-rebuild switch; then
    echo "NIXOS REBUILD COMPLETED"
    
    if [ -f "/etc/nixos/flake.lock" ]; then
        echo "Updating git's flake.lock"
        sudo cp "/etc/nixos/flake.lock" "/home/$current_user/nix-config/flake.lock"
        sudo chown $current_user:users "/home/$current_user/nix-config/flake.lock"
    else
        echo "No flake.lock found in /etc/nixos. Skipping flake.lock update."
    fi

    # Change ownership of the copied files to root
    sudo chown -R root: "$nixos_dir/" || { echo "Ownership change failed"; exit 1; }
    echo "Changed ownership of files in $nixos_dir to root."

    # Change to nix-config directory
    cd "$config_dir"

    # Check if in a Git repository
    if [ ! -d ".git" ]; then
        echo "Not a Git repository. Exiting."
        exit 1
    fi

    # Git commit and push
    if ! git diff-index --quiet HEAD --; then
        read -p "Enter commit message: " commit_message
        git add .
        git commit -m "$commit_message"
        git push origin master
    else
        echo "No changes to commit."
    fi
else
    echo "NIXOS REBUILD FAILED. Previous configuration restored."
    sudo rm -rf "$nixos_dir"
    sudo cp -r "$backup_dir/nixos" "$nixos_dir"
fi

# Clean up the temporary backup
sudo rm -rf "$backup_dir"