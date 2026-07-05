# Dotfiles

Personal configuration files.

## Files

- `common/.gitconfig` - Git configuration
- `linux/.bash_aliases` - Shell aliases with smart `ll` (uses eza if available, falls back to ls)
- `linux/tmux.conf` - Linux tmux configuration
- `linux/keyd/default.conf` - Keyd configuration
- `macos/` - macOS-specific dotfiles
- `windows/WindowsPowerShell/Microsoft.PowerShell_profile.ps1` - Windows PowerShell profile
- `install.py` - Installation script with OS detection and automatic backup

## Install

```bash
./install.py
```

This will:
1. Backup existing dotfiles to `backup-YYYY-MM-DD.tar.gz` (if any exist)
2. Detect Linux, macOS, or Windows
3. Copy common dotfiles and OS-specific dotfiles to their proper locations
4. On headless Linux, copy the extra headless dotfiles such as `linux/keyd/default.conf`

## Windows PowerShell Profile

If Windows PowerShell reports that `Microsoft.PowerShell_profile.ps1` cannot be loaded because running scripts is disabled, run this in PowerShell:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
Unblock-File -Path "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
```

`Set-ExecutionPolicy` allows locally created profile scripts for your current user. `Unblock-File` clears the downloaded-file block for this specific profile file if Windows marked it as remote.

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
