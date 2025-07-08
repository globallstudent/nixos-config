#!/usr/bin/env bash

echo "=== Terminal Blur Diagnostics ==="
echo "Date: $(date)"
echo

# Check session type
echo "1. Session Information:"
echo "   Session type: $XDG_SESSION_TYPE"
echo "   Wayland display: $WAYLAND_DISPLAY"
echo "   X11 display: $DISPLAY"
echo "   Desktop: $XDG_CURRENT_DESKTOP"
echo "   Compositor: $(ps aux | grep -E '(mutter|kwin|sway)' | grep -v grep | head -1 | awk '{print $11}')"
echo

# Check GNOME Shell version
echo "2. GNOME Shell version:"
gnome-shell --version 2>/dev/null || echo "   Not available"
echo

# Check Mutter experimental features
echo "3. Mutter experimental features:"
gsettings get org.gnome.mutter experimental-features
echo

# Check Blur My Shell settings
echo "4. Blur My Shell settings:"
echo "   Applications blur: $(gsettings get org.gnome.shell.extensions.blur-my-shell.applications blur 2>/dev/null || echo 'Not set')"
echo "   Applications opacity: $(gsettings get org.gnome.shell.extensions.blur-my-shell.applications opacity 2>/dev/null || echo 'Not set')"
echo "   Applications sigma: $(gsettings get org.gnome.shell.extensions.blur-my-shell.applications sigma 2>/dev/null || echo 'Not set')"
echo "   Settings version: $(gsettings get org.gnome.shell.extensions.blur-my-shell settings-version 2>/dev/null || echo 'Not set')"
echo

# Check available terminals
echo "5. Available terminals:"
which alacritty >/dev/null && echo "   ✓ Alacritty: $(which alacritty)"
which kitty >/dev/null && echo "   ✓ Kitty: $(which kitty)"
which gnome-terminal >/dev/null && echo "   ✓ GNOME Terminal: $(which gnome-terminal)"
echo

# Test Alacritty transparency
echo "6. Testing Alacritty with transparency..."
if which alacritty >/dev/null; then
    echo "   Starting Alacritty with opacity 0.7..."
    alacritty --config-file <(cat <<EOF
window:
  opacity: 0.7
  decorations: "Full"
  decorations_theme_variant: "Dark"
  blur: true
colors:
  primary:
    background: "#0a0a0a"
    foreground: "#c9d1d9"
font:
  normal:
    family: "Cascadia Code PL"
  size: 12
EOF
) &
    ALACRITTY_PID=$!
    echo "   Alacritty started with PID: $ALACRITTY_PID"
else
    echo "   Alacritty not found"
fi
echo

# Test Kitty blur
echo "7. Testing Kitty with background blur..."
if which kitty >/dev/null; then
    echo "   Starting Kitty with background blur..."
    kitty --config NONE \
        -o background_opacity=0.75 \
        -o background_blur=25 \
        -o font_family="Cascadia Code PL" \
        -o font_size=12 \
        -o foreground="#c9d1d9" \
        -o background="#0a0a0a" &
    KITTY_PID=$!
    echo "   Kitty started with PID: $KITTY_PID"
else
    echo "   Kitty not found"
fi
echo

echo "8. Recommendations:"
echo "   - Look at both terminal windows to compare blur effects"
echo "   - Kitty generally has better Wayland blur support"
echo "   - If neither shows blur, try logging out and selecting 'GNOME on Xorg'"
echo "   - Ensure windows are over colored backgrounds to see transparency"
echo
echo "   To kill test terminals:"
echo "   killall alacritty kitty"
echo
echo "   To switch to X11 session:"
echo "   1. Log out"
echo "   2. Click the gear icon on login screen"
echo "   3. Select 'GNOME on Xorg'"
echo "   4. Log back in"
echo
echo "=== Diagnostics Complete ==="
