#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# The directory where your plasma-manager config file resides
CONFIG_DIR="$HOME/nix-config/home-manager/king/plasma-manager"
# The final Nix configuration file
TARGET_FILE="$CONFIG_DIR/default.nix"
# The command to run plasma-manager's dump feature
DUMP_COMMAND="nix run github:nix-community/plasma-manager -- dump"
# The formatter command to use
FORMATTER_COMMAND="nix run nixpkgs#nixpkgs-fmt --"
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
if ! $DUMP_COMMAND > "$TMP_DUMP_FILE"; then
  echo "Error: Failed to run '$DUMP_COMMAND'" >&2
  exit 1
fi
echo "Dump successful."

echo "Processing dumped configuration..."
# Remove the first line ('{') and the last line ('}')
sed '1d;$d' "$TMP_DUMP_FILE" > "$TMP_BODY_FILE"

# Fix the Yakuake shortcut issue by cleaning up the toggle-window-state line
echo "Fixing Yakuake shortcut configuration..."
sed -i 's/"yakuake"\."toggle-window-state" = "Ctrl+Space,F12,Open\/Retract Yakuake";/"yakuake"."toggle-window-state" = "Ctrl+Space";/' "$TMP_BODY_FILE"

# Check if processing resulted in an empty file
if [ ! -s "$TMP_BODY_FILE" ]; then
    echo "Error: Processing the dump resulted in an empty file." >&2
    echo "Please check the output of '$DUMP_COMMAND' manually." >&2
    exit 1
fi

echo "Writing final Nix configuration to: $TARGET_FILE"

# Write the header, overwriting the target file
cat > "$TARGET_FILE" << EOF
{ inputs, ... }: {
  imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
EOF

# Append the processed body
cat "$TMP_BODY_FILE" >> "$TARGET_FILE"

# Append the final closing brace
echo "" >> "$TARGET_FILE"
echo "}" >> "$TARGET_FILE"

echo "Formatting the generated Nix file using ${FORMATTER_COMMAND% --}..."
if ! $FORMATTER_COMMAND "$TARGET_FILE"; then
    echo "Warning: Failed to format '$TARGET_FILE'. The file might be valid but unformatted." >&2
else
    echo "Formatting successful."
fi

echo "Successfully updated and formatted $TARGET_FILE"
echo "Note: Yakuake shortcut has been cleaned up to remove Wayland-related duplicate shortcuts."

exit 0
