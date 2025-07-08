#!/usr/bin/env bash

echo "Alacritty Blur Testing & Fixes"
echo "=============================="
echo

# Check current session type
echo "1. Current session info:"
echo "Session type: $XDG_SESSION_TYPE"
echo "Desktop: $XDG_CURRENT_DESKTOP"
echo

# Apply immediate blur settings
echo "2. Applying blur settings immediately..."
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/blur "true"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/enable-all "false"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/opacity "240"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/sigma "15"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/whitelist "['Alacritty', 'alacritty', 'org.alacritty.Alacritty']"

echo "✓ Applied Blur My Shell settings for Alacritty"

# Enable additional Mutter features
echo "3. Enabling enhanced compositor features..."
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer', 'kms-modifiers', 'rt-scheduler']"
echo "✓ Enhanced Mutter experimental features"

# Restart GNOME Shell for changes to take effect
echo "4. Restarting GNOME Shell..."
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting for blur effects…")'
else
    killall -3 gnome-shell
fi

sleep 3

# Test Alacritty
echo "5. Testing Alacritty with blur..."
killall alacritty 2>/dev/null || true
sleep 1
alacritty &
sleep 2

echo
echo "✓ Testing complete!"
echo
echo "If blur still doesn't work on Wayland, try:"
echo "1. Log out and select 'GNOME on Xorg' at login screen"
echo "2. X11 has better blur support than Wayland"
echo "3. Alternatively, we can install Kitty which has better Wayland blur support"
echo
echo "Current setup should show:"
echo "• Transparent terminal background"
echo "• Dark borders matching system theme"
echo "• Background blur effect (if compositor supports it)"
echo
echo "To switch to X11 session:"
echo "• Log out → Click gear icon → Select 'GNOME on Xorg'"
