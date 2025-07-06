{ config, pkgs, inputs, ... }:

{
  home.username = "yunus";
  home.homeDirectory = "/home/yunus";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop

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

    # GNOME tools
    gnome.gnome-tweaks
    gnome.gnome-shell-extensions
    gnome.gnome-extensions-app
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.ding
    gnomeExtensions.user-themes
    gnomeExtensions.caffeine

    # Fonts & icon themes
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
    tela-icon-theme
    gnome.adwaita-icon-theme
    gnome-themes-extra
  ];

  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    GOBIN = "${config.home.homeDirectory}/go/bin";
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
    extensions = with pkgs.vscode-extensions; [
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

  home.stateVersion = "25.05";
}
