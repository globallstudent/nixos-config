# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "expertlab";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.3.4"
    "openssl-1.1.1w"
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 1111 ];
    allowedUDPPorts = [ 51820 ];
    allowedTCPPortRanges = [ { from = 30000; to = 32767; } ];
    allowPing = true;
  };
  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

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
  
  #services.activitywatch = {
  #  enable = true;
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixos = {
    isNormalUser = true;
    description = "Asliddin Abdumannonov";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    glibc
    sqlite
  ];

  environment.variables.LD_LIBRARY_PATH =
    lib.mkForce (lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.libgcc
      pkgs.glibc
      pkgs.zlib
      pkgs.sqlite
    ]);  

  # Install firefox.
  programs.firefox.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = ["git" "sudo" "docker"];
    };
  };

  programs.starship.enable = true;

  services.flatpak.enable = true;

  users.defaultUserShell = pkgs.zsh;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    tmux
    google-chrome
    telegram-desktop
    neovim
    zsh
    python312
    go
    vscode
    jetbrains.pycharm-community-bin
    jetbrains.goland
    alacritty
    postman
    oh-my-zsh   
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
    
    
    htop
    gtop
    code-cursor
    docker
    tree-sitter
    ripgrep
    lazygit
    bottom
    nodejs-slim
    curl
    uv
    sqlite
    activitywatch

    cmake
    gnumake
    gcc
    popsicle
    zlib
    nix-ld

    rustup
    rustc
    cargo
	
    postgresql
    fastfetch
    neofetch
    libreoffice
    yandex-music
    jetbrains-toolbox
    warp-terminal
    nodejs_22
    pnpm
    windterm
    mongodb-compass
    pgadmin4
    beekeeper-studio
    anydesk
    redis
    redisinsight
    nix-index
    flatpak
    dig
    appflowy
    sublime4
    element-desktop
    floorp-bin
    obs-studio
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    appimage-run
    starship
  ];

  virtualisation.docker.enable = true;
  

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  services.openssh = {
    enable = true;
    openFirewall = true;   # auto-adds TCP/22
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
