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

  # Environment packages
  environment.systemPackages = with pkgs; [
    postgresql_15
  ] ++ import ../../modules/packages.nix { inherit pkgs; };

  system.stateVersion = "25.05";
}
