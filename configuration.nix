# /etc/nixos/configuration.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/base.nix
    ./modules/locale.nix
    ./modules/networking.nix
    ./modules/desktop.nix
    ./modules/users.nix
    ./modules/devtools.nix
    ./modules/services.nix
    ./modules/docker.nix
    ./modules/packages.nix
  ];

  system.stateVersion = "25.05";
}
