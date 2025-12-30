# packages and services

{ config, pkgs, ... }:

{
  
  # audio (pipewire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  #############

  # packages

  # enable programs
  programs = {
  	firefox.enable = true; # firefox
  	thunar.enable = true; # file manager
  	xfconf.enable = true; # xfconf for thunar
  };
  programs.thunar.plugins = with pkgs.xfce; [ # thunar extensions
    thunar-archive-plugin
    thunar-volman
  ];


  #############


  # services
  
    services = {
    	lact.enable = true; # gpu manager
    	desktopManager.gnome.enable = true; # gnome
        gnome.core-apps.enable = true;
        gnome.core-developer-tools.enable = false;
    	gnome.games.enable = false;
    	gvfs.enable = true; # device management for thunar
    	tumbler.enable = true; # thumbnail plugin for thunar
    };

    # flatpak
    services.flatpak.enable = true;
      systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
          flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
      };


  #############


  # general applications

  environment.systemPackages = with pkgs; [

    # spotify and spicetify
	spotify    

    # terminal and utilities
    ghostty
    kitty
    alacritty
    unzip
    wl-clipboard
    git
    gh
    btop
    micro
    vim
    imagemagick

    # programming
    python3
    
    # apps
    vesktop
    discord
    nwg-look
    vscode
    krita
    nwg-displays
    google-chrome
    obs-studio
    mangohud
    heroic
    appimage-run
    vlc
    ffmpeg
    grim
    ani-cli
    anydesk
    
    # htprland and customization
    hyprshot
    hyprlock
    rofi
    pywal
    cava
    tty-clock
    mako
    fastfetch
    swww
    pipes
    tuigreet
    waybar
    pywalfox-native

    # gnome
    gnome-tweaks
    gnomeExtensions.hide-top-bar

    # random things
    psmisc
    libnotify
    playerctl
    protonup-qt
    zsh-powerlevel10k
    pavucontrol
    pulseaudio
    edid-decode

    #amd tools and drivers
    radeontop
    lact
    winetricks
    wineasio
    dxvk
    vkd3d
    mesa
    ];
    
    #############


    # esclude gnome paclages
    environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
}
