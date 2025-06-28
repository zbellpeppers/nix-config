#!/usr/bin/env zsh

setopt errexit
setopt nounset
setopt pipefail

CURRENT_USER=$USER

# Define valid rebuild commands
typeset -a valid_commands
valid_commands=(switch boot test build dry-activate build-vm build-vm-with-bootloader build-image edit)

# Define commands that will skip the git process
typeset -a skip_git_commands
skip_git_commands=(test build dry-activate build-vm build-vm-with-bootloader build-image edit)

# Initialize flags
run_garbage_collection=false
update_flake_inputs=false

# Create log directory
LOG_DIR="$HOME/.cache/nixos-rebuild-logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/rebuild-$(date +%Y%m%d-%H%M%S).log"

# Function to display usage
show_usage() {
    print "Usage: $0 [command] [flags...]"
    print "Valid commands: ${valid_commands[*]}"
    print "Special flags:"
    print "  --gc              Run garbage collection before rebuild"
    print "  --update-inputs   Update flake inputs before rebuild"
    print "Examples:"
    print "  $0 switch"
    print "  $0 switch --gc"
    print "  $0 switch --upflake"
    print "  $0 build-image --image-variant iso"
}

# Function to run garbage collection
run_gc() {
    print "🗑️  Running garbage collection..."
    if sudo nix-collect-garbage -d 2>&1 | tee -a "$LOG_FILE"; then
        print "✅ Garbage collection completed"
    else
        print "⚠️  Garbage collection had issues, but continuing..."
    fi
}

# Function to update flake inputs
update_flake_inputs_func() {
    print "❄️ Updating flake inputs..."
    cd ~/nix-config
    if nix flake update 2>&1 | tee -a "$LOG_FILE"; then
        print "✅ Flake inputs updated"
    else
        print "⚠️ Failed to update flake inputs"
        exit 1
    fi
}

# Function to send desktop notification
send_desktop_notification() {
    local title="$1"
    local message="$2"
    local icon="$3"

    if command -v notify-send &> /dev/null && [[ -n "$DISPLAY" ]]; then
        notify-send "$title" "$message" --icon="$icon" 2>/dev/null || true
    fi
}

# Function to restore backup on failure
restore_backup() {
    print "Restoring backup from $backup_dir"
    sudo rm -rf /etc/nixos
    sudo cp -r "$backup_dir/nixos" /etc/nixos
    sudo rm -rf "$backup_dir"
}

# Function to capture current system closure
capture_current_system() {
    if [[ -L /run/current-system ]]; then
        readlink /run/current-system
    else
        echo ""
    fi
}

# Function to generate package update report
generate_update_report() {
    local old_system="$1"
    local new_system="$2"
    local report_file="$3"

    if [[ -z "$old_system" ]] || [[ -z "$new_system" ]]; then
        print "No system comparison available" > "$report_file"
        return
    fi

    print "NixOS System Update Report" > "$report_file"
    print "=========================" >> "$report_file"
    print "Date: $(date)" >> "$report_file"
    print "Old system: $old_system" >> "$report_file"
    print "New system: $new_system" >> "$report_file"
    print "" >> "$report_file"

    # Use nix store diff-closures to compare the systems
    if command -v nix &> /dev/null; then
        print "Package Changes:" >> "$report_file"
        print "---------------" >> "$report_file"

        # Capture the diff output
        if nix store diff-closures "$old_system" "$new_system" 2>/dev/null >> "$report_file"; then
            # Check if there were actually any changes
            if ! grep -q "→" "$report_file"; then
                print "No package changes detected." >> "$report_file"
            fi
        else
            print "Unable to generate detailed package diff." >> "$report_file"
            print "This might be due to missing old system reference." >> "$report_file"
        fi
    else
        print "Nix command not available for detailed comparison." >> "$report_file"
    fi

    print "" >> "$report_file"
}

# Parse command-line arguments and extract special flags
typeset -a rebuild_args
rebuild_command=""

if (($# == 0)); then
    rebuild_command="switch"
else
    for arg in "$@"; do
        case $arg in
            --gc)
                run_garbage_collection=true
                ;;
            --upflake)
                update_flake_inputs=true
                ;;
            *)
                if [[ -z "$rebuild_command" ]]; then
                    rebuild_command="$arg"
                else
                    rebuild_args+=("$arg")
                fi
                ;;
        esac
    done

    # If no command was specified (only flags), default to switch
    if [[ -z "$rebuild_command" ]]; then
        rebuild_command="switch"
    fi
fi

# Validate the rebuild command
if (( ! ${valid_commands[(Ie)$rebuild_command]} )); then
    print "Error: Invalid rebuild command: $rebuild_command"
    show_usage
    exit 1
fi


# Initialize log file
print "NixOS Rebuild Log - $(date)" > "$LOG_FILE"
print "Command: $rebuild_command ${rebuild_args[*]}" >> "$LOG_FILE"
print "Flags: GC=$run_garbage_collection, Update-Inputs=$update_flake_inputs" >> "$LOG_FILE"
print "========================================" >> "$LOG_FILE"

# Run garbage collection if requested
if [[ "$run_garbage_collection" == true ]]; then
    run_gc
fi

# Update flake inputs if requested
if [[ "$update_flake_inputs" == true ]]; then
    update_flake_inputs_func
fi


# Check if we should skip git operations
if (( ${skip_git_commands[(Ie)$rebuild_command]} )); then
    print "Command '$rebuild_command' detected. Will skip git operations."
    commit_message=""
    skip_git=true
else
    # Ask user for a commit message at the beginning
    print "Enter a commit message (or press Enter for default message):"
    read -r user_message

    # Use default message if user didn't provide one
    if [[ -z "$user_message" ]]; then
        build_id=$(date +"%Y%m%d-%H%M%S")
        commit_message="nixos - build #$build_id"
    else
        commit_message="$user_message"
    fi
    skip_git=false
fi

# Capture current system before rebuild
print "Capturing current system state..."
old_system_path=$(capture_current_system)

# Create a temporary backup directory
backup_dir=$(mktemp -d)
print "Creating backup of /etc/nixos in $backup_dir"
sudo cp -r /etc/nixos "$backup_dir"

# Sync files from ~/nix-config to /etc/nixos
print "Syncing files from ~/nix-config to /etc/nixos"
sudo rsync -a --delete --exclude='.git' ~/nix-config/ /etc/nixos/

# Perform the rebuild
typeset -a rebuild_cmd
if (( ${#rebuild_args[@]} == 0 )); then
    print "Starting NixOS rebuild with command: $rebuild_command"
    rebuild_cmd=(sudo nixos-rebuild "$rebuild_command")
else
    print "Starting NixOS rebuild with command: $rebuild_command ${rebuild_args[*]}"
    rebuild_cmd=(sudo nixos-rebuild "$rebuild_command" "${rebuild_args[@]}")
fi

cd /etc/nixos

# Record start time for logging
start_time=$(date +%s)

# Run the rebuild with all arguments and log output
print "Executing: ${rebuild_cmd[*]}" | tee -a "$LOG_FILE"
if ${rebuild_cmd[@]} 2>&1 | tee -a "$LOG_FILE"; then
    rebuild_success=true
    print "NixOS rebuild completed successfully." | tee -a "$LOG_FILE"
else
    rebuild_success=false
    print "NixOS rebuild failed." | tee -a "$LOG_FILE"
fi

# Calculate duration
end_time=$(date +%s)
duration=$((end_time - start_time))

# Handle success/failure
if [[ "$rebuild_success" == true ]]; then
    # Send desktop notification for success
    send_desktop_notification "NixOS Update" "System rebuild completed successfully!" "system-software-update"

    # Capture new system state after successful rebuild
    new_system_path=$(capture_current_system)

    # Generate update report for commands that actually change the system
    if [[ "$rebuild_command" == "switch" || "$rebuild_command" == "boot" ]]; then
        # Create temporary file for the update report
        report_file=$(mktemp --suffix=.txt)

        print "Generating package update report..."
        generate_update_report "$old_system_path" "$new_system_path" "$report_file"

        # Display success message with report location
        print ""
        print "✅ NixOS rebuild completed successfully!"
        print "🗒️ You can find a list of all packages that were updated this rebuild at '$report_file'"
        print "📔 Full rebuild log available at '$LOG_FILE'"
        print "⏱️  Rebuild duration: ${duration} seconds"
        print ""

        # Optionally show a preview of changes
        if grep -q "→" "$report_file"; then
            print "📦 Preview of package changes:"
            grep "→" "$report_file" | head -10
            if [[ $(grep -c "→" "$report_file") -gt 10 ]]; then
                print "... and $(( $(grep -c "→" "$report_file") - 10 )) more changes (see full report above)"
            fi
            print ""
        fi
    fi

    # Update flake.lock in the git repo if it exists in /etc/nixos
    if [[ -f /etc/nixos/flake.lock ]]; then
        print "Updating flake.lock in git repository"
        # Remove the old flake.lock if it exists
        [[ -f ~/nix-config/flake.lock ]] && sudo rm ~/nix-config/flake.lock
        # Copy the new flake.lock and set proper ownership
        sudo cp /etc/nixos/flake.lock ~/nix-config/
        sudo chown "$CURRENT_USER" ~/nix-config/flake.lock
    fi

    # Change ownership of /etc/nixos files to root
    sudo chown -R root:root /etc/nixos
    print "Changed ownership of /etc/nixos files to root."

    # Clean up the backup
    sudo rm -rf "$backup_dir"

    # Handle git operations based on command type
    if [[ "$skip_git" == true ]]; then
        print "Command '$rebuild_command' completed. Skipping git operations as planned."
        exit 0
    fi

    # Change to the nix-config directory for git operations
    cd ~/nix-config

    # Perform Git operations
    print "Performing git operations..."
    git add .
    print "Using commit message: $commit_message"
    git commit -m "$commit_message"
    git push

    print "Changes committed and pushed to Git repository."
else
    # Send desktop notification for failure
    send_desktop_notification "NixOS Update Failed" "System rebuild encountered errors. Check the logs." "dialog-error"

    print "⚠️ Rebuild failed after ${duration} seconds"
    if [[ "$skip_git" == false && -n "$commit_message" ]]; then
        print "   Your commit message was: \"$commit_message\""
    fi
    print "📔 Check the full log at '$LOG_FILE' for details"
    restore_backup
    exit 1
fi