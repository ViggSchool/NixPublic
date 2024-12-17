{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # FIXME Add UUID
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/";

  networking.hostName = "nixos";
  networking.wireless = {
    enable = false;
    networks."".psk = ""; # FIXME Add psk and host
  }; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Stockholm";
  
  console = {
    font = "Lat2-Terminus16";
    keyMap = "sv-latin1";
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.viggo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

environment.gnome.excludePackages = with pkgs; [
    orca
    evince
    # file-roller
    geary
    gnome-disk-utility
    seahorse
    # sushi
    sysprof
    # gnome-shell-extensions
    # adwaita-icon-theme
    # nixos-background-info
    gnome-backgrounds
    # gnome-bluetooth
    gnome-color-manager
    # gnome-control-center
    # gnome-shell-extensions
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    gnome-user-docs
    # glib # for gsettings program
    # gnome-menus
    # gtk3.out # for gtk-launch program
    # xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
    # xdg-user-dirs-gtk # Used to create the default bookmarks
    #
    baobab
    epiphany
    gnome-text-editor
    # gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    # gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    # loupe
    # nautilus
    gnome-connections
    simple-scan
    snapshot
    # totem
    yelp
    gnome-software
  ];

  environment.systemPackages = with pkgs; [
    vim
    fastfetch
  ];

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Do not change!
}
