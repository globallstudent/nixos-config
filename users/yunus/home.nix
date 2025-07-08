{ config, pkgs, ayugram-desktop, ... }:

{
  imports = [
    ../../modules/programs
  ];

  home.username = "yunus";
  home.homeDirectory = "/home/yunus";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
    
    # Fonts & themes
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
    tela-icon-theme
    adwaita-icon-theme
    gnome-themes-extra
  ];

  programs.git = {
    enable = true;
    userName = "Asliddin";
    userEmail = "asliddinabdumannonov06@gmail.com";
  };



  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      golang.go
      rust-lang.rust-analyzer
    ];
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    font = {
      name = "Cascadia Code PL";
      package = pkgs.cascadia-code;
      size = 11;
    };
  };

  # Enable dconf for persistent GNOME settings
  dconf.enable = true;

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Terminal.desktop"
        "code.desktop"
        "google-chrome.desktop"
        "org.gnome.Nautilus.desktop"
        "telegramdesktop.desktop"
        "alacritty.desktop"
      ];
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
    };
    
    # Desktop background
    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-l.jpg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.jpg";
    };

    # Interface settings
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      show-battery-percentage = true;
      clock-show-weekday = true;
      clock-show-date = true;
      enable-animations = true;
      gtk-enable-primary-paste = false;
      # System fonts
      font-name = "Cascadia Code PL 11";
      document-font-name = "Cascadia Code PL 11";
      monospace-font-name = "Cascadia Code PL 10";
    };

    # Window manager settings and keybindings
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "click";
      workspace-names = ["Main" "Work" "Media" "Other"];
      audible-bell = false;
      auto-raise = true;
      # Window title font
      titlebar-font = "Cascadia Code PL Bold 11";
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = ["<Alt>Tab"];
      switch-applications-backward = ["<Shift><Alt>Tab"];
      switch-windows = ["<Super>Tab"];
      switch-windows-backward = ["<Shift><Super>Tab"];
      close = ["<Super>q"];
      maximize = ["<Super>Up"];
      unmaximize = ["<Super>Down"];
      minimize = ["<Super>h"];
    };
    
    # Power settings
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-battery-timeout = 1800;
      power-button-action = "interactive";
    };

    # Nautilus preferences
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
      show-create-link = true;
      show-delete-permanently = true;
    };

    # Touchpad settings
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      natural-scroll = true;
      two-finger-scrolling-enabled = true;
    };

    # Terminal preferences
    "org/gnome/terminal/legacy/profiles:" = {
      default = "b1dcc9dd-5262-4d8d-a863-c897e6d979b9";
      list = ["b1dcc9dd-5262-4d8d-a863-c897e6d979b9"];
    };
    "org/gnome/terminal/legacy/profiles:.b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
      audible-bell = false;
      use-system-font = true;
      scrollbar-policy = "never";
      visible-name = "Default";
    };

    # Extension Settings
    # Aztaskbar settings
    "org/gnome/shell/extensions/aztaskbar" = {
      clock-font-size = "(false, 14)";
      clock-position-offset = 0;
      favorites-on-all-monitors = true;
      intellihide = false;
      isolate-monitors = true;
      isolate-workspaces = false;
      main-panel-height = "(true, 36)";
      override-panel-clock-format = "(false, '%A, %B %d - %H∶%M')";
      panel-location = "TOP";
      position-offset = 1;
      prefs-visible-page = "";
      show-apps-button = "(false, 0)";
      show-panel-activities-button = true;
      show-weather-by-clock = "OFF";
      taskbar-spacing = 0;
      tool-tips = true;
      update-notifier-project-version = 30;
      window-preview-title-font-size = 11;
      window-previews = true;
    };

    # Blur my shell settings
    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };
    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;   # Re-enable for terminal blur
      blur-on-overview = true;
      enable-all = false;  # Only whitelist specific apps
      opacity = 240;  # Slight opacity for blur effect
      sigma = 15;     # Blur intensity
      whitelist = ["Alacritty" "alacritty" "org.alacritty.Alacritty"];  # Multiple variants
    };
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.59999999999999998;
      sigma = 30;
    };
    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
      pipeline = "pipeline_default";
    };
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.59999999999999998;
      pipeline = "pipeline_default_rounded";
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };
    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      pipeline = "pipeline_default";
    };
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      pipeline = "pipeline_default";
    };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.59999999999999998;
      pipeline = "pipeline_default";
      sigma = 30;
    };
    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      pipeline = "pipeline_default";
    };
    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.59999999999999998;
      sigma = 30;
    };

    # Caffeine settings
    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 2;
      user-enabled = false;
    };

    # Dash to dock settings
    "org/gnome/shell/extensions/dash-to-dock" = {
      autohide = true;
      dock-fixed = false;
      dock-position = "BOTTOM";
      extend-height = false;
      intellihide = true;
    };

    # GTK4 Desktop Icons NG (ding) settings
    "org/gnome/shell/extensions/gtk4-desktop-icons-ng-ding" = {
      icon-size = "standard";
      show-home = true;
      show-mounted-volumes = true;
      show-trash = true;
    };

    # GTK4 ding settings
    "org/gnome/shell/extensions/gtk4-ding" = {
      add-volumes-opposite = true;
      dark-text-in-labels = false;
      show-trash = false;
      show-volumes = false;
      start-corner = "top-right";
    };

    # Vitals settings
    "org/gnome/shell/extensions/vitals" = {
      alphabetize = true;
      fixed-widths = true;
      hide-icons = false;
      hide-zeros = false;
      icon-style = 1;
      menu-centered = false;
      show-battery = false;
      show-fan = true;
      show-memory = true;
      show-network = true;
      show-processor = true;
      show-storage = true;
      show-system = true;
      show-temperature = true;
      show-voltage = true;
      update-time = 5;
      use-higher-precision = false;
    };

    # Enable experimental Mutter features for better effects
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer" "kms-modifiers" "rt-scheduler"];
    };

    # Touchpad gesture customization settings
    "org/gnome/shell/extensions/touchpad-gesture-customization" = {
      allow-minimize-window = true;
      vertical-swipe-3-fingers-gesture = "WINDOW_MANIPULATION";
      vertical-swipe-4-fingers-gesture = "OVERVIEW_NAVIGATION";
    };
  };

  # Rust toolchain configuration
  # Removed sccache wrapper as it's not installed
  # home.file.".cargo/config.toml".text = ''
  #   [build]
  #   rustc-wrapper = "sccache"
  # '';

  home.sessionVariables = {
    GOPATH = "/home/yunus/go";
    GOBIN = "/home/yunus/go/bin";
    CARGO_HOME = "/home/yunus/.cargo";
    RUSTUP_HOME = "/home/yunus/.rustup";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Rust setup activation script
  home.activation.rustupSetup = ''
    if [[ ! -d "$HOME/.rustup" ]]; then
      echo "Setting up Rust toolchain..."
      ${pkgs.rustup}/bin/rustup default stable
      ${pkgs.rustup}/bin/rustup component add clippy rustfmt rust-analyzer
    fi
  '';

  # AstroNvim configuration
  home.file = {
    ".config/nvim/init.lua".source = ../../modules/astronvim/init.lua;
    ".config/nvim/lua".source = ../../modules/astronvim/lua;
    ".config/nvim/.stylua.toml".source = ../../modules/astronvim/.stylua.toml;
    ".config/nvim/.neoconf.json".source = ../../modules/astronvim/.neoconf.json;
    ".config/nvim/extra-lua".source = ../../modules/astronvim/extra-lua;
  };

  home.stateVersion = "25.05";
}
