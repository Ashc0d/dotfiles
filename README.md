# Dotfiles

Personal configuration files.

## Files

- `.bash_aliases` - Shell aliases with smart `ll` (uses eza if available, falls back to ls)
- `tmux.conf` - Tmux configuration
- `install.sh` - Installation script with automatic backup

## Install

```bash
./install.sh
```

This will:
1. Backup existing dotfiles to `backup-YYYY-MM-DD.tar.gz` (if any exist)
2. Copy new configuration files to their proper locations

## Optional

Install [eza](https://github.com/eza-community/eza) for an enhanced `ll` command with better colors and git integration.

```bash
# Ubuntu/Debian
sudo apt install eza

# macOS
brew install eza

# Arch Linux
sudo pacman -S eza
```
