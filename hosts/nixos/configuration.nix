{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.yunus = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
    shellInit = ''
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix
    '';
  };

  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.gnome.core-apps.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-browser-connector.enable = true; # required for extensions.gnome.org

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "gnome";
    };
    mime = {
      enable = true;
      defaultApplications = {
        "text/html" = "google-chrome.desktop";
        "x-scheme-handler/http" = "google-chrome.desktop";
        "x-scheme-handler/https" = "google-chrome.desktop";
        "x-scheme-handler/telegram" = "telegramdesktop.desktop";
      };
    };
  };


  services.openssh.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;

  # Enable PostgreSQL service
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32           trust
      host    all             all             ::1/128                trust
    '';
    ensureDatabases = [ "yunus" ];
    ensureUsers = [{
      name = "yunus";
      ensureDBOwnership = true;
      ensureClauses = {
        superuser = true;
        createrole = true;
        createdb = true;
      };
    }];
    # Initialize with some basic extensions
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
      CREATE EXTENSION IF NOT EXISTS "hstore";
      CREATE EXTENSION IF NOT EXISTS "pg_trgm";
    '';
  };

  # Desktop applications
  programs.firefox.enable = true;

  # Environment packages
  environment = {
    systemPackages = with pkgs; [
      # System essentials
      postgresql_15
      tree
      fastfetch
      neofetch
      eza
      bat
      htop
      unzip
      file
      wget
      curl
      gnome-tweaks
      gnome-shell-extensions
      gnome-extension-manager

      # Desktop apps with proper desktop entries
      vscode
      ((google-chrome.override {
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
      }))
      telegram-desktop
      alacritty
      kitty  # Alternative terminal with better blur support on Wayland

      # Development tools
      git
      gcc
      python3
      python3Packages.pip
      python3Packages.virtualenv
      uv  # Python package and project manager
      go
      rustup
      gdb
      openjdk
      jdk
      maven
      gradle

      # GNOME extensions
      gnomeExtensions.dash-to-dock
      gnomeExtensions.appindicator
      gnomeExtensions.gtk4-desktop-icons-ng-ding
      gnomeExtensions.caffeine
      gnomeExtensions.blur-my-shell
      gnomeExtensions.vitals
      gnomeExtensions.touchpad-gesture-customization
      # Additional extensions from your current setup
      # Note: Some extensions might need to be installed manually from extensions.gnome.org
      # if they're not available in nixpkgs
      # aztaskbar - needs manual installation
      # gtk4-ding - might need manual installation
    ] ++ import ../../modules/packages.nix { inherit pkgs; };
  };

  # Desktop Integration
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  # Font configuration
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      cascadia-code
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" "Liberation Serif" ];
        sansSerif = [ "Noto Sans" "Liberation Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" "Liberation Mono" ];
      };
    };
  };

  # Enable flatpak support
  services.flatpak.enable = true;

  # Network Manager configuration
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  system.stateVersion = "25.05";
}
