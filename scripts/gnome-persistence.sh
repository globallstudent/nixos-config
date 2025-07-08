#!/usr/bin/env bash

# Script to apply GNOME settings and make them persistent
# This ensures that any changes made through GNOME Settings or Extensions
# are properly saved and persist across reboots

echo "Setting up GNOME persistence..."

# Ensure dconf directory exists
mkdir -p "$HOME/.config/dconf"

# Load current dconf settings
dconf load / < /dev/null 2>/dev/null || true

# Enable GNOME Shell extensions if they're not already enabled
extensions=(
    "dash-to-dock@micxgx.gmail.com"
    "gtk4-desktop-icons@gnome-shell-extensions.g-c.online" 
    "appindicatorsupport@rgcjonas.gmail.com"
    "caffeine@patapon.info"
    "blur-my-shell@aunetx"
    "Vitals@CoreCoding.com"
)

for ext in "${extensions[@]}"; do
    gnome-extensions enable "$ext" 2>/dev/null || true
done

# Restart GNOME Shell to apply changes (only works in X11)
if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
    busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")' 2>/dev/null || true
fi

echo "GNOME persistence setup complete!"
echo "Note: Some changes may require logging out and back in to take effect."
