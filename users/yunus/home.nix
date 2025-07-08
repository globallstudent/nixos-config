{ config, pkgs, ayugram-desktop, ... }:

{
  home.username = "yunus";
  home.homeDirectory = "/home/yunus";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    ayugram-desktop.packages.${pkgs.system}.ayugram-desktop

    # Daily apps
    vscode
    telegram-desktop
    alacritty
    google-chrome
    tree fastfetch neofetch eza bat htop unzip file wget curl

    # Dev essentials
    git zsh gcc

    # Languages
    python3
    python3Packages.pip
    python3Packages.virtualenv
    go
    rustup
    gcc
    gdb
    openjdk
    jdk
    maven
    gradle
    
    # GNOME tools
    gnome-tweaks
    gnome-shell-extensions
    #gnomeExtensions.dash-to-dock
    #gnomeExtensions.appindicator
    #gnomeExtensions.ding
    #gnomeExtensions.user-themes
    #gnomeExtensions.caffeine

    # Fonts & icon themes
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
    tela-icon-theme
    adwaita-icon-theme
    gnome-themes-extra

  ];

  home.sessionVariables = {
    GOPATH = "/home/yunus/go";
    GOBIN = "/home/yunus/go/bin";
  };

  programs.git = {
    enable = true;
    userName = "Asliddin";
    userEmail = "asliddinabdumannonov06@gmail.com";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      golang.go
      rust-lang.rust-analyzer
    ];
  };

  programs.alacritty.enable = true;

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
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 11;
    };
  };

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
    };
  };

  home.file.".config/nvim".source = ../../modules/astronvim;

  home.stateVersion = "25.05";
}
