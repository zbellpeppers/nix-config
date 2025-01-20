
#!/bin/sh

# Exit Immediately if any command fails
set -e

# Define directories
config_dir="/home/zachary/nix-config"
nixos_dir="/etc/nixos"

# Remove existing files in /etc/nixos
sudo rm -rf "$nixos_dir/"*
echo "Removed existing files in $nixos_dir."

# Copy files from ~/nix-config to /etc/nixos
sudo cp -r "$config_dir/"* "$nixos_dir/" || { echo "Copy failed"; exit 1; }
echo "Copied files from $config_dir to $nixos_dir."

# Change ownership of the copied files to root
sudo chown -R root: "$nixos_dir/" || { echo "Ownership change failed"; exit 1; }
echo "Changed ownership of files in $nixos_dir to root."

# Rebuild System
sudo nixos-rebuild switch

# Check if rebuild was successful
if [ $? -eq 0 ]; then
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
fi