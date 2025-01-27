
#!/bin/bash

# Set up logging
log_file="/var/log/nixos-rebuild-$(date +%Y%m%d-%H%M%S).log"
exec > >(tee -a "$log_file") 2>&1

# Exit Immediately if any command fails
set -e

# Define directories
config_dir="/home/zachary/nix-config"
nixos_dir="/etc/nixos"
backup_dir=$(mktemp -d)

# Backup existing /etc/nixos
sudo cp -r "$nixos_dir" "$backup_dir"
echo "Backed up existing $nixos_dir to $backup_dir."

# Remove existing files in /etc/nixos
sudo rm -rf "$nixos_dir/"*
echo "Removed existing files in $nixos_dir."

# Copy files from ~/nix-config to /etc/nixos
sudo cp -r "$config_dir/"* "$nixos_dir/" || { echo "Copy failed"; exit 1; }
echo "Copied files from $config_dir to $nixos_dir."

# Change ownership of the copied files to root
sudo chown -R root: "$nixos_dir/" || { echo "Ownership change failed"; exit 1; }
echo "Changed ownership of files in $nixos_dir to root."

# Attempt to rebuild the system
if sudo nixos-rebuild switch; then
    echo "NIXOS REBUILD HAS COMPLETED SUCCESSFULLY"

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
    echo "NIXOS REBUILD FAILED"
    echo "Restoring previous configuration..."
    sudo rm -rf "$nixos_dir"
    sudo cp -r "$backup_dir/nixos" "$nixos_dir"
    echo "Previous configuration restored. Please check your changes and try again."
fi

# Clean up the temporary backup
sudo rm -rf "$backup_dir"