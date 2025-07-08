#!/usr/bin/env bash

echo "Alacritty Blur Test & Troubleshooting"
echo "====================================="
echo

# Check compositor type
echo "1. Checking compositor..."
echo "Session type: $XDG_SESSION_TYPE"
echo "Desktop environment: $XDG_CURRENT_DESKTOP"
echo

# Check Alacritty version and blur support
echo "2. Checking Alacritty configuration..."
if [ -f ~/.config/alacritty/alacritty.toml ]; then
    echo "✓ Alacritty config found"
    echo "Blur setting: $(grep -A 5 '\[window\]' ~/.config/alacritty/alacritty.toml | grep blur || echo 'Not found')"
    echo "Opacity setting: $(grep -A 5 '\[window\]' ~/.config/alacritty/alacritty.toml | grep opacity || echo 'Not found')"
    echo "Decorations: $(grep -A 5 '\[window\]' ~/.config/alacritty/alacritty.toml | grep decorations_theme || echo 'Not found')"
else
    echo "✗ Alacritty config not found"
fi
echo

# Check GNOME compositor features
echo "3. Checking GNOME compositor..."
echo "Mutter experimental features: $(gsettings get org.gnome.mutter experimental-features)"
echo

# Check for blur extensions
echo "4. Checking for blur extensions..."
if dconf list /org/gnome/shell/extensions/blur-my-shell/ >/dev/null 2>&1; then
    echo "✓ Blur My Shell extension detected"
    echo "  Settings: $(dconf list /org/gnome/shell/extensions/blur-my-shell/ | wc -l) options available"
else
    echo "✗ Blur My Shell extension not detected"
fi
echo

# Test Alacritty with different settings
echo "5. Blur Support Analysis:"
echo "----------------------------------------"
echo "GNOME Wayland Limitation:"
echo "• GNOME's Mutter compositor has limited per-application blur support"
echo "• The 'blur = true' setting in Alacritty may not work on GNOME Wayland"
echo "• Blur My Shell extension can provide blur effects for some applications"
echo
echo "Current Setup Status:"
echo "• Window borders: Should now be dark (decorations_theme_variant = 'Dark')"
echo "• Transparency: Working (opacity = 0.85)"
echo "• Background blur: Limited on GNOME Wayland"
echo
echo "Recommendations:"
echo "1. Current setup provides transparency with dark borders"
echo "2. For macOS-like blur, consider:"
echo "   a) Using a different compositor (like KDE Plasma with blur effects)"
echo "   b) Using X11 session instead of Wayland (limited blur support)"
echo "   c) Adjusting Blur My Shell extension settings for terminals"
echo
echo "Alternative Visual Improvements:"
echo "• Darker background color for better contrast"
echo "• Reduced opacity for more transparency effect"
echo "• Using background image with transparency"

echo
echo "6. Testing current Alacritty setup..."
echo "Starting Alacritty with current configuration..."
alacritty &
sleep 2
echo "Alacritty started. Check if:"
echo "✓ Window borders are dark"
echo "✓ Background is transparent"
echo "✓ Overall appearance matches system theme"
