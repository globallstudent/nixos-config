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

  programs.zsh.enable = true;

  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.gnome.core-utilities.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-browser-connector.enable = true; # required for extensions.gnome.org

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gnome ];


  networking.networkmanager.enable = true;
  services.openssh.enable = true;


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;



  environment.systemPackages = import ../../modules/packages.nix { inherit pkgs; };

  system.stateVersion = "25.05";
}
