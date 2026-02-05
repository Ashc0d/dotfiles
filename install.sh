#!/bin/bash

# Dotfiles Installation Script
# Copies dotfiles from repo to home directory, backing up existing files

set -e

# Get script directory (repo location)
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
DATE=$(date +%Y-%m-%d)
BACKUP_FILE="$REPO_DIR/backup-$DATE.tar.gz"

# Destination files
DEST_BASH_ALIASES="$HOME/.bash_aliases"
DEST_TMUX_CONF="$HOME/.config/tmux/tmux.conf"

# Source files in repo
SRC_BASH_ALIASES="$REPO_DIR/.bash_aliases"
SRC_TMUX_CONF="$REPO_DIR/tmux.conf"

echo "Installing dotfiles..."

# Check which destination files exist and collect them for backup
EXISTING_FILES=()

if [ -e "$DEST_BASH_ALIASES" ]; then
    EXISTING_FILES+=("$DEST_BASH_ALIASES")
fi

if [ -e "$DEST_TMUX_CONF" ]; then
    EXISTING_FILES+=("$DEST_TMUX_CONF")
fi

# Create backup if any files exist
if [ ${#EXISTING_FILES[@]} -gt 0 ]; then
    echo "Found ${#EXISTING_FILES[@]} existing file(s), creating $BACKUP_FILE..."
    tar -czf "$BACKUP_FILE" -C / "${EXISTING_FILES[@]#/}"
    echo "Backup created: $BACKUP_FILE"
fi

# Create destination directories if they don't exist
mkdir -p "$(dirname "$DEST_TMUX_CONF")"

# Copy files from repo to destinations
echo "Copying dotfiles..."

if [ -e "$SRC_BASH_ALIASES" ]; then
    cp "$SRC_BASH_ALIASES" "$DEST_BASH_ALIASES"
    echo "  ✓ Installed: ~/.bash_aliases"
else
    echo "  ✗ Source not found: .bash_aliases"
    exit 1
fi

if [ -e "$SRC_TMUX_CONF" ]; then
    cp "$SRC_TMUX_CONF" "$DEST_TMUX_CONF"
    echo "  ✓ Installed: ~/.config/tmux/tmux.conf"
else
    echo "  ✗ Source not found: tmux.conf"
    exit 1
fi

echo ""
echo "Done! Run 'source ~/.bashrc' to apply changes."
