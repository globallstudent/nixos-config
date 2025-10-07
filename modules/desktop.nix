{ config, pkgs, lib, ... }:
{
  # Display server & GNOME
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Printing
  services.printing.enable = true;

  # Audio: PipeWire (with PulseAudio replacement)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true; # uncomment if you need JACK apps
  };

  # Flatpak runtime support
  services.flatpak.enable = true;
}
