#!/bin/bash

CONFIG_DIR="/home/caleb/Projects/vscode-ish-dotfiles/configs"

echo "Updating configurations from current editor setup..."

# Update from VSCodium if available
if [ -f "$HOME/.config/VSCodium/User/settings.json" ]; then
    cp "$HOME/.config/VSCodium/User/settings.json" "$CONFIG_DIR/"
    cp "$HOME/.config/VSCodium/User/keybindings.json" "$CONFIG_DIR/"
    codium --list-extensions > "$CONFIG_DIR/extensions.txt"
    echo "✓ Updated from VSCodium"
elif [ -f "$HOME/.config/Windsurf/User/settings.json" ]; then
    cp "$HOME/.config/Windsurf/User/settings.json" "$CONFIG_DIR/"
    cp "$HOME/.config/Windsurf/User/keybindings.json" "$CONFIG_DIR/"
    echo "✓ Updated from Windsurf"
else
    echo "⚠ No editor configurations found to update from"
fi

echo ""
echo "Configuration updated! Remember to commit and push changes:"
echo "  cd /home/caleb/Projects/vscode-ish-dotfiles"
echo "  git add ."
echo "  git commit -m 'Update configurations'"
echo "  git push"
