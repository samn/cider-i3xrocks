#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DEST="/usr/share/i3xrocks/scripts"
CONF_DEST="/usr/share/i3xrocks/conf.d"

# Check dependencies
missing=()
for cmd in curl jq xrescat; do
  command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
done
if [[ ${#missing[@]} -gt 0 ]]; then
  echo "Error: missing dependencies: ${missing[*]}"
  echo "Install them with: sudo apt install ${missing[*]}"
  exit 1
fi

# Install script
sudo install -Dm755 "$SCRIPT_DIR/scripts/cider" "$SCRIPTS_DEST/cider"
echo "Installed script to $SCRIPTS_DEST/cider"

# Install config
sudo install -Dm644 "$SCRIPT_DIR/conf.d/50_cider" "$CONF_DEST/50_cider"
echo "Installed config to $CONF_DEST/50_cider"

# Set up token directory
TOKEN_DIR="$HOME/.config/cider-i3xrocks"
mkdir -p "$TOKEN_DIR"
chmod 700 "$TOKEN_DIR"

if [[ ! -f "$TOKEN_DIR/token" ]]; then
  echo ""
  echo "Next step: add your Cider RPC API token:"
  echo "  echo 'your-token-here' > $TOKEN_DIR/token"
  echo "  chmod 600 $TOKEN_DIR/token"
else
  echo "Token file already exists at $TOKEN_DIR/token"
fi

echo ""
echo "Done! Reload i3 to activate: regolith-look refresh"
