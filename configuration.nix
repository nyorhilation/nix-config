# general configuration

{ config, pkgs, ... }:

{ # import configuration files
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./shell.nix
    ./themes.nix
  ];


  #############

  # user settings
  users.users.nora = {
    isNormalUser = true;
    description = "nora";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "power" "video" "audio" ];
  };

  # hostname and network
  networking.hostName = "tichelmorres";
  networking.networkmanager.enable = true;

  # xserver
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # printing and graphics
  services.printing.enable = true;
  hardware.opengl = {
  	enable = true;
  	driSupport32Bit = true;
  };
  
  #############


  # environment variables
   environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "gnome";
    XDG_CURRENT_DESKTOP = "Gnome";
    QT_QPA_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    ELECTRON_ENABLE_WAYLAND = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland,x11";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    EDITOR = "micro";
    VISUAL = "micro";
    };


  #############

 
  # activate flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  #############

  
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  #############

  
  # time, keyboard and locale
  time.timeZone = "America/Fortaleza"; # time
  console.keyMap = "br-abnt2"; # keyboard layout
  
  # locale
  i18n = {
  defaultLocale = "en_US.UTF-8";
  extraLocales = [ "fr_FR.UTF-8/UTF-8" ];
  };
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };


  #############


  # display manager
  systemd.defaultUnit = "graphical.target";
  systemd.services."getty@tty1".enable = false;
  security.pam.services.greetd = {};
  services.seatd.enable = true;
  services.greetd = {
    enable = false;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet";
      };
    };
  };
  services.displayManager.gdm.enable = true;

  #############

  
  # security polkit
  security.polkit.enable = true;
  	

  #############

  # packages

  # allow unfree
    nixpkgs.config.allowUnfree = true;

  # steam
  programs.steam = {
     enable = true;
     remotePlay.openFirewall = true;
     dedicatedServer.openFirewall = true;
 };
 
  programs.gamemode.enable = true; # gamemode


  #############


  # hyprland
  programs.hyprland = { 
    enable = true;
    xwayland.enable = true;
    };


  #############

    
  # System version
  system.stateVersion = "23.11";
}
