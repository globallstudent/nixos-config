{ config, pkgs, lib, ... }:
{
  networking.hostName = "expertlab";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 1111 ];
    allowedUDPPorts = [ 51820 ];
    allowedTCPPortRanges = [ { from = 30000; to = 32767; } ];
    allowPing = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = true; # auto-opens TCP/22
  };
}
