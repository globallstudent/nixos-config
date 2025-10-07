{ config, pkgs, lib, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    # shells & editors
    vim neovim zsh
    # cli utils
    wget git tmux curl htop gtop bottom ripgrep lazygit tree-sitter fastfetch neofetch dig
    # browsers & desktop apps
    google-chrome telegram-desktop libreoffice yandex-music element-desktop floorp-bin obs-studio
    # terminals
    alacritty warp-terminal windterm
    # dev tools
    python312 go nodejs-slim nodejs_22 pnpm uv sqlite cmake gnumake gcc zlib nix-ld
    rustup rustc cargo
    # IDEs
    vscode jetbrains.pycharm-community-bin jetbrains.goland jetbrains-toolbox code-cursor
    # APIs/HTTP
    postman
    # DB tools
    postgresql pgadmin4 mongodb-compass beekeeper-studio redis redisinsight
    # gnome extensions (installed as packages)
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.system-monitor
    gnomeExtensions.vuemeter-system
    gnomeExtensions.gsconnect
    gnomeExtensions.gtk4-desktop-icons-ng-ding
    gnomeExtensions.desktop-icons-ng-ding
    gnomeExtensions.logo-menu
    gnomeExtensions.space-bar
    gnomeExtensions.lan-ip-address
    gnomeExtensions.task-widget
    gnomeExtensions.dash-in-panel
    gnomeExtensions.keep-awake
    gnomeExtensions.wiggle
    gnomeExtensions.wireguard-vpn-extension
    # misc
    anydesk popsicle nix-index flatpak appflowy sublime4 appimage-run starship
    gpu-screen-recorder gpu-screen-recorder-gtk

    nixpkgs-fmt statix
  ];
}
