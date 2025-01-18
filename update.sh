#!/bin/bash

# Define directories
config_dir=~/nix-config
nixos_dir=/etc/nixos

# Copy files from ~/nix-config to /etc/nixos
sudo cp -r "$config_dir/"* "$nixos_dir/"
echo "Copied files from $config_dir to $nixos_dir."

# Change ownership of the copied files to root
sudo chown -R root: "$nixos_dir/"
echo "Changed ownership of files in $nixos_dir to root."

# Update Nix Flake and Rebuild
cd "$nixos_dir" && sudo nix flake update && sudo nixos-rebuild switch

# Check if rebuild was successful
if [ $? -eq 0 ]; then
    echo "NIXOS REBUILD HAS COMPLETED SUCCESSFULLY"

    # Git commit and push
    git add .
    read -p "Enter commit message: " commit_message
    git commit -m "$commit_message"
    git push origin master
else
    echo "NIXOS REBUILD FAILED"
fi