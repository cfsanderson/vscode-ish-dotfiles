#!/bin/bash

SCRIPT_DIR="/home/caleb/Projects/vscode-ish-dotfiles"
CONFIG_DIR="$SCRIPT_DIR/configs"

# Editor config paths
declare -A EDITORS=(
    ["VSCodium"]="$HOME/.config/VSCodium/User"
    ["Windsurf"]="$HOME/.config/Windsurf/User"
)

echo "Installing VSCode-ish editor configurations..."

for editor in "${!EDITORS[@]}"; do
    config_path="${EDITORS[$editor]}"
    
    # Check if the editor's parent directory exists
    if [ -d "$(dirname "$config_path")" ] || [ "$editor" = "VSCodium" ] || [ "$editor" = "Windsurf" ]; then
        echo "Setting up $editor..."
        
        # Create User directory if it doesn't exist
        mkdir -p "$config_path"
        
        # Backup existing configs
        if [ -f "$config_path/settings.json" ]; then
            cp "$config_path/settings.json" "$config_path/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
            echo "  - Backed up existing settings.json"
        fi
        if [ -f "$config_path/keybindings.json" ]; then
            cp "$config_path/keybindings.json" "$config_path/keybindings.json.backup.$(date +%Y%m%d_%H%M%S)"
            echo "  - Backed up existing keybindings.json"
        fi
        
        # Remove existing files/symlinks
        rm -f "$config_path/settings.json"
        rm -f "$config_path/keybindings.json"
        
        # Create symlinks
        ln -sf "$CONFIG_DIR/settings.json" "$config_path/settings.json"
        ln -sf "$CONFIG_DIR/keybindings.json" "$config_path/keybindings.json"
        
        echo "✓ $editor configured with symlinks"
    else
        echo "⚠ $editor directory not found, skipping..."
    fi
done

echo ""
echo "Installation complete!"
echo "Your configurations are now managed from: $CONFIG_DIR"
