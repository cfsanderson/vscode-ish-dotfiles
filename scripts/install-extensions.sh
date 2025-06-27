#!/bin/bash

CONFIG_DIR="/home/caleb/Projects/vscode-ish-dotfiles/configs"
EXTENSIONS_FILE="$CONFIG_DIR/extensions.txt"

if [ ! -f "$EXTENSIONS_FILE" ]; then
    echo "Extensions file not found: $EXTENSIONS_FILE"
    exit 1
fi

echo "Installing extensions..."

# Install for VSCodium
if command -v codium &> /dev/null; then
    echo "Installing extensions for VSCodium..."
    while IFS= read -r extension; do
        if [[ ! "$extension" =~ ^#.* ]] && [[ -n "$extension" ]]; then
            echo "  Installing: $extension"
            codium --install-extension "$extension"
        fi
    done < "$EXTENSIONS_FILE"
    echo "✓ VSCodium extensions installed"
else
    echo "⚠ VSCodium not found at /usr/bin/codium"
fi

# Install for Windsurf (if it supports extension installation)
if command -v windsurf &> /dev/null; then
    echo "Installing extensions for Windsurf..."
    while IFS= read -r extension; do
        if [[ ! "$extension" =~ ^#.* ]] && [[ -n "$extension" ]]; then
            echo "  Installing: $extension"
            windsurf --install-extension "$extension" 2>/dev/null || echo "    Failed to install $extension in Windsurf"
        fi
    done < "$EXTENSIONS_FILE"
    echo "✓ Windsurf extensions attempted"
else
    echo "⚠ Windsurf not found at /usr/bin/windsurf"
fi

echo "Extension installation complete!"
