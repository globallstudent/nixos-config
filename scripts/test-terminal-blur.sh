#!/usr/bin/env bash

echo "=== Terminal Blur Test Script ==="
echo "Testing blur capabilities on your system"
echo

# Kill any existing terminals
killall alacritty kitty 2>/dev/null || true
sleep 1

# Check session type
echo "Session: $XDG_SESSION_TYPE"
echo "Desktop: $XDG_CURRENT_DESKTOP"
echo

# Create test configs
mkdir -p /tmp/terminal-tests

# Kitty config with blur
cat > /tmp/terminal-tests/kitty.conf << 'EOF'
# Kitty blur test configuration
background_opacity 0.75
background_blur 30
font_family Cascadia Code PL
font_size 13
foreground #c9d1d9
background #0a0a0a
window_padding_width 15
enable_audio_bell no
cursor_shape block
cursor_blink_interval 0
remember_window_size yes
initial_window_width 100c
initial_window_height 30c
EOF

# Alacritty config with transparency
cat > /tmp/terminal-tests/alacritty.toml << 'EOF'
# Alacritty transparency test configuration
[window]
opacity = 0.75
decorations = "Full"
decorations_theme_variant = "Dark"
dynamic_title = true
padding = { x = 15, y = 15 }

[colors.primary]
background = "#0a0a0a"
foreground = "#c9d1d9"

[font]
size = 13.0

[font.normal]
family = "Cascadia Code PL"

[env]
TERM = "xterm-256color"
EOF

echo "1. Testing Kitty with background_blur..."
kitty --config=/tmp/terminal-tests/kitty.conf --title="Kitty Blur Test" &
KITTY_PID=$!
echo "   Started Kitty (PID: $KITTY_PID)"

echo
echo "2. Testing Alacritty with opacity..."
alacritty --config-file /tmp/terminal-tests/alacritty.toml --title="Alacritty Transparency Test" &
ALACRITTY_PID=$!
echo "   Started Alacritty (PID: $ALACRITTY_PID)"

echo
echo "3. Visual Test Instructions:"
echo "   • Two terminal windows should now be open"
echo "   • Move them over different colored backgrounds"
echo "   • Look for:"
echo "     - Kitty: Should show background blur effect"
echo "     - Alacritty: Should show transparency (no blur on Wayland)"
echo "   • Kitty generally has better Wayland blur support"
echo

echo "4. Current Status:"
echo "   Session Type: $XDG_SESSION_TYPE"
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "   ✓ Running on Wayland - Kitty blur should work"
    echo "   ⚠ Alacritty blur limited on Wayland (transparency only)"
else
    echo "   ✓ Running on X11 - Both terminals should support effects"
fi

echo
echo "5. Troubleshooting:"
echo "   If no effects are visible:"
echo "   • Try logging out and selecting 'GNOME on Xorg' instead"
echo "   • Ensure you're testing over colored backgrounds"
echo "   • Check that compositor effects are enabled"

echo
echo "6. To clean up:"
echo "   killall alacritty kitty"
echo "   rm -rf /tmp/terminal-tests"

echo
echo "=== Test Complete ==="
echo "Leave terminals open to compare effects, or press Ctrl+C to stop"

# Wait for user input
read -p "Press Enter to close test terminals..." input
killall alacritty kitty 2>/dev/null || true
rm -rf /tmp/terminal-tests
echo "Cleanup complete."
