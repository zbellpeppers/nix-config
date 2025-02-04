
#!/bin/bash

# Set the path to the git repository
REPO_PATH="/etc/nixos"

# Change to the repository directory
cd "$REPO_PATH" || exit 1

# Pull the latest changes
git pull origin

# Rebuild NixOS
sudo nixos-rebuild switch

echo "NixOS configuration updated and rebuilt successfully!"