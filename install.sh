#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.local/share/sabaz-adb-toolkit"
BIN_DIR="${HOME}/.local/bin"

mkdir -p "$TARGET_DIR" "$BIN_DIR"
cp "$SCRIPT_DIR/adb_toolkit.sh" "$TARGET_DIR/adb_toolkit.sh"
chmod +x "$TARGET_DIR/adb_toolkit.sh"
ln -sf "$TARGET_DIR/adb_toolkit.sh" "$BIN_DIR/sabaz-adb"

echo "Installed successfully."
echo "Run with: sabaz-adb"
echo
if ! command -v adb >/dev/null 2>&1; then
    echo "ADB is not installed yet."
    echo "Debian/Ubuntu/Kali: sudo apt update && sudo apt install adb -y"
    echo "Termux: pkg update && pkg install android-tools"
fi

echo
case ":$PATH:" in
    *":$BIN_DIR:"*) ;;
    *) echo "If 'sabaz-adb' is not found, add this to ~/.bashrc: export PATH=\"\$HOME/.local/bin:\$PATH\"" ;;
esac
