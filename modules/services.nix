{ config, pkgs, lib, ... }:
{
  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE  USER      ADDRESS       METHOD
      local   all       all                     trust
      host    all       all       127.0.0.1/32  trust
      host    all       all       ::1/128       trust
    '';
  };

  services.redis = {
    servers."".enable = true;
  };
}
