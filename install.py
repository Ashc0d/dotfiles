#!/usr/bin/env python3

from __future__ import annotations

import os
import platform
import shutil
import sys
import tarfile
from datetime import date
from pathlib import Path


REPO_DIR = Path(__file__).resolve().parent
BACKUP_FILE = REPO_DIR / f"backup-{date.today().isoformat()}.tar.gz"

COMMON_DOTFILES = {
    "common/.gitconfig": "~/.gitconfig",
}

OS_DOTFILES = {
    "linux": {
        "linux/.bash_aliases": "~/.bash_aliases",
        "linux/tmux.conf": "~/.config/tmux/tmux.conf",
    },
    "macos": {},
    "windows": {},
}

LINUX_HEADLESS_DOTFILES = {
    "linux/keyd/default.conf": "~/.config/keyd/default.conf",
}


def detect_os() -> str:
    system = platform.system().lower()

    if system == "darwin":
        return "macos"
    if system == "linux":
        return "linux"
    if system == "windows":
        return "windows"

    raise RuntimeError(f"Unsupported operating system: {platform.system()}")


def is_headless_linux() -> bool:
    return not (os.environ.get("DISPLAY") or os.environ.get("WAYLAND_DISPLAY"))


def expand_destination(destination: str) -> Path:
    return Path(destination).expanduser()


def build_registry(os_name: str) -> dict[str, str]:
    registry = dict(COMMON_DOTFILES)
    registry.update(OS_DOTFILES.get(os_name, {}))

    if os_name == "linux" and is_headless_linux():
        registry.update(LINUX_HEADLESS_DOTFILES)

    return registry


def create_backup(destinations: list[Path]) -> None:
    existing_files = [path for path in destinations if path.exists()]

    if not existing_files:
        return

    print(f"Found {len(existing_files)} existing file(s), creating {BACKUP_FILE}...")
    with tarfile.open(BACKUP_FILE, "w:gz") as archive:
        for path in existing_files:
            archive.add(path, arcname=str(path).lstrip(os.sep))

    print(f"Backup created: {BACKUP_FILE}")


def install_dotfiles(registry: dict[str, str]) -> None:
    print("Copying dotfiles...")

    for source, destination in registry.items():
        source_path = REPO_DIR / source
        destination_path = expand_destination(destination)

        if not source_path.exists():
            raise FileNotFoundError(f"Source not found: {source}")

        destination_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source_path, destination_path)
        print(f"  Installed: {destination}")


def main() -> int:
    try:
        os_name = detect_os()
        registry = build_registry(os_name)
        destinations = [expand_destination(destination) for destination in registry.values()]

        print(f"Installing dotfiles for {os_name}...")
        if os_name == "linux":
            mode = "headless" if is_headless_linux() else "desktop"
            print(f"Linux mode: {mode}")

        create_backup(destinations)
        install_dotfiles(registry)

        print("")
        print("Done! Restart your shell or source the updated config to apply changes.")
        return 0
    except Exception as error:
        print(f"Error: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
