#!/usr/bin/env bash

echo "=== Fixing Blur My Shell Reverse Blur Issue ==="
echo

# Kill existing terminals to start fresh
echo "1. Stopping existing terminals..."
killall alacritty kitty 2>/dev/null || true
sleep 1

# Force disable and enable the extension
echo "2. Reloading Blur My Shell extension..."
gnome-extensions disable blur-my-shell@aunetx
sleep 2
gnome-extensions enable blur-my-shell@aunetx
sleep 3

# Try to set the extension settings directly
echo "3. Configuring Blur My Shell settings..."

# Method 1: Try with gsettings (may not work if schemas aren't loaded)
echo "   Attempting gsettings configuration..."
gsettings set org.gnome.shell.extensions.blur-my-shell.applications blur false 2>/dev/null && echo "     ✓ Disabled applications blur" || echo "     ⚠ gsettings not available"
gsettings set org.gnome.shell.extensions.blur-my-shell.applications opacity 255 2>/dev/null && echo "     ✓ Set applications opacity to 255" || echo "     ⚠ gsettings opacity not available"
gsettings set org.gnome.shell.extensions.blur-my-shell.applications sigma 0 2>/dev/null && echo "     ✓ Set applications sigma to 0" || echo "     ⚠ gsettings sigma not available"

# Method 2: Direct dconf write (alternative approach)
echo "   Attempting direct dconf configuration..."
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/blur false 2>/dev/null && echo "     ✓ dconf: Disabled applications blur" || echo "     ⚠ dconf applications blur not accessible"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/opacity 255 2>/dev/null && echo "     ✓ dconf: Set applications opacity" || echo "     ⚠ dconf applications opacity not accessible"
dconf write /org/gnome/shell/extensions/blur-my-shell/applications/sigma 0 2>/dev/null && echo "     ✓ dconf: Set applications sigma" || echo "     ⚠ dconf applications sigma not accessible"

echo
echo "4. Testing terminal blur configuration..."

# Create improved Alacritty config for better blur testing
cat > /tmp/alacritty-blur-test.toml << 'EOF'
[window]
opacity = 0.7
decorations = "Full"
decorations_theme_variant = "Dark"
dynamic_title = true
padding = { x = 20, y = 20 }

[colors.primary]
background = "#0f0f0f"
foreground = "#e0e0e0"

[font]
size = 14.0

[font.normal]
family = "Cascadia Code PL"

[env]
TERM = "xterm-256color"
EOF

# Create Kitty config with blur
cat > /tmp/kitty-blur-test.conf << 'EOF'
background_opacity 0.7
background_blur 35
font_family Cascadia Code PL
font_size 14
foreground #e0e0e0
background #0f0f0f
window_padding_width 20
enable_audio_bell no
cursor_shape block
cursor_blink_interval 0
remember_window_size yes
initial_window_width 90c
initial_window_height 25c
EOF

echo "   Starting Alacritty with improved transparency..."
alacritty --config-file /tmp/alacritty-blur-test.toml --title="Alacritty - Fixed Blur Test" &
ALACRITTY_PID=$!

echo "   Starting Kitty with background blur..."
kitty --config=/tmp/kitty-blur-test.conf --title="Kitty - Background Blur Test" &
KITTY_PID=$!

echo
echo "5. Test Instructions:"
echo "   → Click on the Alacritty window and move it around"
echo "   → It should now have its own transparency/blur effect"
echo "   → NOT be blurred by other windows"
echo "   → Click on Kitty and verify it has proper background blur"
echo
echo "6. If this fixes the issue:"
echo "   → The Home Manager configuration needs to be rebuilt"
echo "   → I can enable permanent Kitty configuration"
echo "   → Alacritty will work with transparency (blur on X11 only)"
echo
echo "7. To clean up test:"
echo "   killall alacritty kitty"
echo "   rm /tmp/alacritty-blur-test.toml /tmp/kitty-blur-test.conf"
echo
echo "=== Fix Applied ==="
echo "Test the terminals and let me know if the reverse blur is fixed!"
