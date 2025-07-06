{ config, pkgs, ... }:

{
  home.username = "yunus";
  home.homeDirectory = "/home/yunus";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    vscode
    telegram-desktop
    alacritty
    git
    zsh
    starship
    eza
    bat
    htop
    neofetch
    fastfetch
    unzip
    file
    google-chrome
    tree
  ];

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

  programs.alacritty.enable = true;

  home.stateVersion = "25.05";
}
