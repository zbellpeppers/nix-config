#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# The directory where your plasma-manager config file resides
CONFIG_DIR="$HOME/nix-config/home-manager/king/plasma-manager"
# The final Nix configuration file
TARGET_FILE="$CONFIG_DIR/default.nix"
# The command to run plasma-manager's dump feature
# Adjust '-- dump' if the actual command is different (e.g., '-- --dump-config')
DUMP_COMMAND="nix run github:nix-community/plasma-manager -- dump"
# Temporary file to store the raw dump
TMP_DUMP_FILE=$(mktemp)
# Temporary file to store the processed body
TMP_BODY_FILE=$(mktemp)

# --- Helper Function ---
cleanup() {
  echo "Cleaning up temporary files..."
  rm -f "$TMP_DUMP_FILE"
  rm -f "$TMP_BODY_FILE"
}

# Register the cleanup function to run on script exit (normal or error)
trap cleanup EXIT

# --- Main Script ---

echo "Ensuring target directory exists: $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"

echo "Running plasma-manager configuration dump..."
# Execute the dump command and store output in the temporary file
if ! $DUMP_COMMAND > "$TMP_DUMP_FILE"; then
  echo "Error: Failed to run '$DUMP_COMMAND'" >&2
  exit 1
fi
echo "Dump successful."

echo "Processing dumped configuration..."
# Use sed to remove the first line (assuming it's '{') and the last line (assuming it's '}')
# This relies on the dump output having '{' and '}' on their own lines.
# - '1d': deletes the first line
# - '$d': deletes the last line
sed '1d;$d' "$TMP_DUMP_FILE" > "$TMP_BODY_FILE"

# Check if processing resulted in an empty file (might indicate dump format changed)
if [ ! -s "$TMP_BODY_FILE" ]; then
    echo "Error: Processing the dump resulted in an empty file." >&2
    echo "Please check the output of '$DUMP_COMMAND' manually." >&2
    exit 1
fi

echo "Writing final Nix configuration to: $TARGET_FILE"

# Write the header, overwriting the target file
# Note: The heredoc preserves indentation.
cat > "$TARGET_FILE" << EOF
{ inputs, ... }: {
  imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
EOF

# Append the processed body (the actual plasma settings)
cat "$TMP_BODY_FILE" >> "$TARGET_FILE"

# Append the final closing brace
# We only need one '}' to close the main attribute set started after '{ inputs, ... }:'
echo "" >> "$TARGET_FILE" # Add a newline for separation
echo "}" >> "$TARGET_FILE"

echo "Successfully updated $TARGET_FILE"

exit 0