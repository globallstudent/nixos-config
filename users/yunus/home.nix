{ config, pkgs, ... }:

{
  home.username = "yunus";
  home.homeDirectory = "/home/yunus";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # UI / daily tools
    vscode
    telegram-desktop
    alacritty
    google-chrome
    tree fastfetch neofetch eza bat htop unzip file wget curl

    # Dev essentials
    git zsh

    # Programming: Python, Go, Rust
    python3
    python3Packages.pip
    python3Packages.virtualenv

    go
    gcc

    rustup
  ];

  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    GOBIN = "${config.home.homeDirectory}/go/bin";
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

  programs.git = {
    enable = true;
    userName = "Asliddin";
    userEmail = "asliddinabdumannonov06@gmail.com";
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

  home.stateVersion = "25.05";
}
