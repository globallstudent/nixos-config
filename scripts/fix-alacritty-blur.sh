#!/usr/bin/env bash

echo "Fixing Alacritty Reverse Blur Effect"
echo "===================================="
echo

# Disable the problematic Blur My Shell application blur immediately
echo "1. Disabling reverse blur effect..."
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/blur "false"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/blur-on-overview "false"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/enable-all "false"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/opacity "255"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/sigma "0"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/whitelist "['']"

echo "✓ Disabled background application blur"
echo

# Kill any existing Alacritty instances
echo "2. Restarting Alacritty..."
killall alacritty 2>/dev/null || true
sleep 1

# Test the fix
echo "3. Testing fixed configuration..."
echo "Starting Alacritty with corrected settings..."
alacritty &
sleep 2

echo
echo "✓ Changes applied immediately!"
echo
echo "What should work now:"
echo "• No more reverse blur on background applications"
echo "• Alacritty has transparent background with dark borders"
echo "• Background content visible through transparency (not blurred)"
echo
echo "Note: True background blur is limited on GNOME Wayland."
echo "The current setup provides clean transparency instead."
echo
echo "Test the terminal - you should see:"
echo "✓ Dark window borders matching system theme"
echo "✓ Transparent background showing desktop behind"
echo "✓ No blur effect on other applications when Alacritty is focused"
