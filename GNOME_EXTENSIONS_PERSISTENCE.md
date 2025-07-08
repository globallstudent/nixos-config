# GNOME Extension Settings Persistence

## Problem Solved

Previously, any GNOME extension settings changed through the GNOME Extensions Manager would be reset to defaults every time `nixos-rebuild` was run. This happened because Home Manager's dconf settings would override the current state.

## Solution

### 1. Captured Current Settings
I've captured all your current GNOME extension settings and added them to your `home.nix` file in the `dconf.settings` section. This includes settings for:

- **Aztaskbar**: Panel customization, clock settings, taskbar behavior
- **Blur my Shell**: Blur effects for dock, panel, overview, etc.
- **Caffeine**: Sleep prevention settings  
- **Dash to Dock**: Dock position, autohide, intellihide behavior
- **GTK4 Desktop Icons**: Desktop icon display settings
- **Vitals**: System monitoring display options
- **Touchpad Gesture Customization**: Touch gesture behaviors

### 2. Updated Extension List
Updated your enabled extensions list to include all currently active extensions:
```nix
enabled-extensions = [
  "dash-to-dock@micxgx.gmail.com"
  "gtk4-desktop-icons@gnome-shell-extensions.g-c.online"
  "appindicatorsupport@rgcjonas.gmail.com"
  "caffeine@patapon.info"
  "blur-my-shell@aunetx"
  "Vitals@CoreCoding.com"
  "aztaskbar@aztaskbar.gitlab.com"
  "gtk4-ding@smedius.gitlab.com"
  "touchpad-gesture-customization@coooolapps.com"
];
```

### 3. Added System Packages
Added the touchpad gesture customization extension to your system packages. Note that some extensions like `aztaskbar` and `gtk4-ding` may need to be installed manually from https://extensions.gnome.org as they're not available in nixpkgs.

## How It Works Now

✅ **Before**: Extension settings reset on every `nixos-rebuild`  
✅ **After**: Extension settings persist across rebuilds

Your GNOME extension settings are now defined in your NixOS configuration and will be consistently applied every time you rebuild your system.

## Future Changes

### Making Changes to Extension Settings

1. **Make changes through GNOME Extensions Manager** (as usual)
2. **Capture the new settings** using the provided script:
   ```bash
   cd ~/nixos-config
   ./scripts/update-gnome-settings.sh --dump
   ```
3. **Copy relevant settings** to your `home.nix` file in the appropriate dconf section
4. **Apply changes**:
   ```bash
   sudo nixos-rebuild switch --flake .
   ```

### Helper Script

The provided script `/home/yunus/nixos-config/scripts/update-gnome-settings.sh` can help you:

- `--list`: Show currently enabled extensions
- `--dump`: Show all current extension settings in Nix format
- `--help`: Show usage information

## Manual Extension Installation

Some extensions not available in nixpkgs need manual installation:

1. **Aztaskbar**: Visit https://extensions.gnome.org/extension/5210/aztaskbar/
2. **GTK4 Ding**: Visit https://extensions.gnome.org/extension/6099/gtk4-ding/

After manual installation, their settings will still be preserved by the dconf configuration in your `home.nix`.

## Files Modified

- `hosts/nixos/configuration.nix`: Added touchpad-gesture-customization extension
- `users/yunus/home.nix`: Added comprehensive extension settings and updated enabled extensions list
- `scripts/update-gnome-settings.sh`: New helper script for future updates