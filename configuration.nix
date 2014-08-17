# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).  

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "gersberms"; # Define your hostname.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
  };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.wacom.enable = true;
  services.xserver.vaapiDrivers = [ pkgs.vaapiIntel ];
  services.xserver.windowManager.i3.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.hb = {
    name = "hb";
    group = "users";
    extraGroups = [ "wheel" ];
    uid = 1000;
    createHome = true;
    home = "/home/hb";
    #shell = "/run/current-system/sw/bin/bash";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  nixpkgs.config = {
    # Firefox ;-)
    allowUnfree = true;
    firefox = {
      enableGoogleTalkPlugin = true;
      #enableAdobeFlash = true;
    };

    chromium = {
      enableGoogleTalkPlugin = true;
      enablePepperFlash = true; # no adobe flash for chromium :-(
      enablePepperPDF = true;
    };
  };

  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    arandr
    chromiumWrapper
    dmenu
    firefoxWrapper
    kde4.konversation
    vim
    wget
    xfce.terminal
    pkgs.zsh
  ];

  # Other environment stuff.
  environment.shells = [ "/run/current-system/sw/bin/zsh" ];
}
