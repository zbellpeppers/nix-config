
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
# The formatter command to use (nixpkgs-fmt is common)
# Alternatives:
# FORMATTER_COMMAND="nix run github:kamadorueda/alejandra --" # If you prefer alejandra
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
# Execute the dump command and store output in the temporary file
if ! $DUMP_COMMAND > "$TMP_DUMP_FILE"; then
  echo "Error: Failed to run '$DUMP_COMMAND'" >&2
  exit 1
fi
echo "Dump successful."

echo "Processing dumped configuration..."
# Use sed to remove the first line (assuming it's '{') and the last line (assuming it's '}')
sed '1d;$d' "$TMP_DUMP_FILE" > "$TMP_BODY_FILE"

# Check if processing resulted in an empty file (might indicate dump format changed)
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

# Append the processed body (the actual plasma settings)
cat "$TMP_BODY_FILE" >> "$TARGET_FILE"

# Append the final closing brace
echo "" >> "$TARGET_FILE" # Add a newline for separation
echo "}" >> "$TARGET_FILE"

echo "Formatting the generated Nix file using ${FORMATTER_COMMAND% --}..."
# Run the chosen formatter on the generated file in-place
# Add || true to make formatting non-fatal, or remove it to make errors stop the script
if ! $FORMATTER_COMMAND "$TARGET_FILE"; then
    echo "Warning: Failed to format '$TARGET_FILE'. The file might be valid but unformatted." >&2
    # Exit 1 here if you want formatting failure to be a critical error
    # exit 1
else
    echo "Formatting successful."
fi


echo "Successfully updated and formatted $TARGET_FILE"

exit 0