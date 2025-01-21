
#!/bin/bash

# Set the path to the git repository
REPO_PATH="/home/sarah/nix-config"

# Change to the repository directory
cd "$REPO_PATH" || exit 1

# Pull the latest changes
git pull origin main

# Copy the updated files to /etc/nixos
sudo cp -R "$REPO_PATH"/* /etc/nixos/

# Rebuild NixOS
sudo nixos-rebuild switch

echo "NixOS configuration updated and rebuilt successfully!"