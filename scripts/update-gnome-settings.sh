#!/usr/bin/env bash

# Script to update GNOME extension settings in Home Manager configuration
# This script captures current dconf settings and updates your home.nix file

set -e

CONFIG_DIR="/home/yunus/nixos-config"
HOME_NIX="$CONFIG_DIR/users/yunus/home.nix"

echo "GNOME Extension Settings Updater"
echo "================================="
echo

# Check if we're in the right directory
if [[ ! -f "$HOME_NIX" ]]; then
    echo "Error: Cannot find home.nix at $HOME_NIX"
    echo "Please run this script from the nixos-config directory"
    exit 1
fi

# Function to dump extension settings
dump_extension_settings() {
    local ext_path="$1"
    local ext_name="$2"
    
    echo "# $ext_name settings"
    echo "\"org/gnome/shell/extensions/$ext_path\" = {"
    
    # Get all keys for this extension
    dconf list "/org/gnome/shell/extensions/$ext_path/" 2>/dev/null | while read -r key; do
        if [[ -n "$key" ]]; then
            # Remove trailing slash from key name
            clean_key="${key%/}"
            value=$(dconf read "/org/gnome/shell/extensions/$ext_path/$clean_key" 2>/dev/null || echo "null")
            
            # Skip if value is empty or null
            if [[ "$value" != "null" && -n "$value" ]]; then
                # Format the value properly for Nix
                if [[ "$value" == "true" || "$value" == "false" ]]; then
                    echo "  $clean_key = $value;"
                elif [[ "$value" =~ ^-?[0-9]+$ ]]; then
                    echo "  $clean_key = $value;"
                elif [[ "$value" =~ ^-?[0-9]*\.[0-9]+$ ]]; then
                    echo "  $clean_key = $value;"
                else
                    # String value - escape quotes
                    escaped_value=$(echo "$value" | sed 's/"/\\"/g')
                    echo "  $clean_key = $escaped_value;"
                fi
            fi
        fi
    done
    
    echo "};"
    echo
}

# Function to show current enabled extensions
show_enabled_extensions() {
    echo "Currently enabled extensions:"
    echo "----------------------------"
    
    enabled_extensions=$(dconf read /org/gnome/shell/enabled-extensions)
    if [[ "$enabled_extensions" != "null" && -n "$enabled_extensions" ]]; then
        echo "$enabled_extensions" | sed 's/\[//' | sed 's/\]//' | sed "s/', '/\n/g" | sed "s/'//g" | sort
    else
        echo "No extensions enabled"
    fi
    echo
}

# Function to backup current home.nix
backup_config() {
    local backup_file="$HOME_NIX.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$HOME_NIX" "$backup_file"
    echo "Created backup: $backup_file"
}

# Function to dump all current extension settings
dump_all_settings() {
    echo "Current extension settings:"
    echo "==========================="
    echo
    
    # Common extensions that might be installed
    local extensions=(
        "dash-to-dock:Dash to Dock"
        "blur-my-shell:Blur my Shell"
        "caffeine:Caffeine"
        "vitals:Vitals"
        "gtk4-desktop-icons-ng-ding:GTK4 Desktop Icons NG"
        "gtk4-ding:GTK4 Ding"
        "aztaskbar:AzTaskbar"
        "touchpad-gesture-customization:Touchpad Gesture Customization"
        "appindicatorsupport:AppIndicator Support"
    )
    
    for entry in "${extensions[@]}"; do
        IFS=':' read -r ext_path ext_name <<< "$entry"
        
        # Check if extension has settings
        if dconf list "/org/gnome/shell/extensions/$ext_path/" >/dev/null 2>&1; then
            dump_extension_settings "$ext_path" "$ext_name"
        fi
    done
    
    # Also dump blur-my-shell sub-settings
    local blur_extensions=(
        "blur-my-shell/appfolder:Blur My Shell - App Folder"
        "blur-my-shell/coverflow-alt-tab:Blur My Shell - Coverflow Alt Tab"
        "blur-my-shell/dash-to-dock:Blur My Shell - Dash to Dock"
        "blur-my-shell/lockscreen:Blur My Shell - Lockscreen"
        "blur-my-shell/overview:Blur My Shell - Overview"
        "blur-my-shell/panel:Blur My Shell - Panel"
        "blur-my-shell/screenshot:Blur My Shell - Screenshot"
        "blur-my-shell/window-list:Blur My Shell - Window List"
    )
    
    for entry in "${blur_extensions[@]}"; do
        IFS=':' read -r ext_path ext_name <<< "$entry"
        
        # Check if extension has settings
        if dconf list "/org/gnome/shell/extensions/$ext_path/" >/dev/null 2>&1; then
            dump_extension_settings "$ext_path" "$ext_name"
        fi
    done
}

# Function to show help
show_help() {
    echo "Usage: $0 [OPTION]"
    echo
    echo "Options:"
    echo "  -l, --list      Show currently enabled extensions"
    echo "  -d, --dump      Dump all current extension settings"
    echo "  -h, --help      Show this help message"
    echo
    echo "Examples:"
    echo "  $0 --list       # Show enabled extensions"
    echo "  $0 --dump       # Show all extension settings"
    echo
    echo "After making changes to GNOME extension settings:"
    echo "1. Run '$0 --dump' to see current settings"
    echo "2. Copy relevant settings to your home.nix"
    echo "3. Run 'sudo nixos-rebuild switch --flake .' to apply"
    echo
    echo "Note: Some extensions may need to be installed manually from"
    echo "https://extensions.gnome.org if they're not available in nixpkgs"
}

# Parse command line arguments
case "${1:-}" in
    -l|--list)
        show_enabled_extensions
        ;;
    -d|--dump)
        dump_all_settings
        ;;
    -h|--help)
        show_help
        ;;
    "")
        show_help
        ;;
    *)
        echo "Unknown option: $1"
        echo "Use --help for usage information"
        exit 1
        ;;
esac
