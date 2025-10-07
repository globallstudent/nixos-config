{ config, pkgs, lib, ... }:
{
  time.timeZone = "Asia/Tashkent";

  i18n.defaultLocale = "en_US.UTF-8";

  # XKB keyboard layout (for X11/Wayland sessions using XKB)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
