#!/usr/bin/env bash

echo "Terminal Blur Solutions for GNOME"
echo "================================="
echo

echo "The Issue:"
echo "GNOME Wayland has limited support for application blur effects."
echo "Alacritty's blur setting often doesn't work on GNOME Wayland."
echo

echo "Available Solutions:"
echo

echo "1. 🆕 KITTY TERMINAL (Recommended)"
echo "   • Better Wayland blur support"
echo "   • Native background_blur setting"
echo "   • Test it now: kitty"
echo

echo "2. 🔄 SWITCH TO X11 SESSION"
echo "   • Much better blur support"
echo "   • Alacritty blur works properly"
echo "   • Steps:"
echo "     - Log out"
echo "     - Click gear icon at login"
echo "     - Select 'GNOME on Xorg'"
echo "     - Log back in"
echo

echo "3. 🎨 TRANSPARENCY INSTEAD OF BLUR"
echo "   • Current Alacritty setup"
echo "   • Clean transparency effect"
echo "   • No blur but good visual appeal"
echo

echo "4. 🔧 BLUR MY SHELL WORKAROUND"
echo "   • Extension-based blur"
echo "   • Limited effectiveness"
echo "   • May cause side effects"
echo

echo "Testing Kitty terminal now..."
if command -v kitty >/dev/null 2>&1; then
    echo "✓ Kitty is available"
    echo "Starting Kitty with blur configuration..."
    kitty &
    sleep 2
    echo "✓ Kitty started - check if blur is working!"
else
    echo "✗ Kitty not found - rebuilding system..."
    sudo nixos-rebuild switch --flake .
fi

echo
echo "RECOMMENDATION:"
echo "==============="
echo "For the best blur experience:"
echo "1. Try Kitty terminal first (should have working blur)"
echo "2. If you prefer Alacritty, switch to X11 session"
echo "3. Current transparency setup is a good fallback"
echo
echo "Which terminal showed blur effects?"
echo "• Kitty: Use 'kitty' command"
echo "• Alacritty with X11: Better than Wayland"
echo "• Current Alacritty: Good transparency without blur"
