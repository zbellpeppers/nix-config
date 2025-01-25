
#!/bin/bash

# Set up logging
log_file="/var/log/nixos-rebuild-$(date +%Y%m%d-%H%M%S).log"
exec > >(tee -a "$log_file") 2>&1

# Exit Immediately if any command fails
set -e

# Define directories
nixos_dir="/etc/nixos"
backup_dir=$(mktemp -d)

# Backup existing /etc/nixos
sudo cp -r "$nixos_dir" "$backup_dir"
echo "Backed up existing $nixos_dir to $backup_dir."

# Attempt to rebuild the system
if sudo nixos-rebuild switch; then
    echo "NIXOS REBUILD HAS COMPLETED SUCCESSFULLY"

    # Change to nix-config directory
    cd "$nixos_dir"

    # Check if in a Git repository
    if [ ! -d ".git" ]; then
        echo "Not a Git repository. Exiting."
        exit 1
    fi

    # Git commit and push
    if [[ -n $(git status --porcelain) ]]; then
        read -p "Enter commit message: " commit_message
        git add . || { echo "Git add failed"; exit 1; }
        git commit -m "$commit_message" || { echo "Git commit failed"; exit 1; }
        git push origin master || { echo "Git push failed"; exit 1; }
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