{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # exports
   environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "hyprland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    ELECTRON_ENABLE_WAYLAND = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    };

  # activate flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname & networking
  networking.hostName = "tichelmorres";
  networking.networkmanager.enable = true;

  # Time
  time.timeZone = "America/Fortaleza";

  # Locale
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

  # xserver
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # greetd + tui
  systemd.defaultUnit = "graphical.target";
  systemd.services."getty@tty1".enable = false;
  security.pam.services.greetd = {};
  services.seatd.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet";
      };
    };
  };

  # security polkit
  security.polkit.enable = true;
  
  # keyboard 
  console.keyMap = "br-abnt2";

  # default apps
  environment.variables = {
    EDITOR = "micro";
    VISUAL = "micro";
  };

  # Printing
  services.printing.enable = true;

  # PipeWire (instead of PulseAudio)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Shells
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "z" "colored-man-pages" ];
    };      
  };
  
    # p10k
    environment.etc."zsh/p10k.zsh".source =
      "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      
    environment.shellInit = ''
      # Load Powerlevel10k ONLY if running in Kitty terminal
      if [[ "$TERM" == *"kitty"* ]] || [[ -n "$KITTY_WINDOW_ID" ]]; then
        source /etc/zsh/p10k.zsh
        [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      fi
      # No else needed - if not Kitty, p10k won't load at all
    '';
  # Flatpak
  services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # gamemode
  programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
        custom = {
          start = "notify-send -a 'Gamemode' 'Optimizations activated'";
          end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
        };
      };
    };

  # opengl drivers
  hardware.graphics.enable = true;
      
  # Users
  users.users.nora = {
    isNormalUser = true;
    description = "nora";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "power" "video" "audio" ];
  };

  # Firefox
  programs.firefox.enable = true;

  # thunar
  programs.thunar.enable = true;

  # Allow unfree packages (Steam, Spotify, etc.)
  nixpkgs.config.allowUnfree = true;

  # System Packages
  # General applications
  environment.systemPackages = with pkgs; [

    # spotify and spicetify
	spotify    

    # terminal and utilities
    kitty
    unzip
    wl-clipboard
    git
    gh
    btop
    micro
    vim
    imagemagick

    # apps
    vesktop
    nwg-look
    vscode
    krita
    nwg-displays
    google-chrome
    obs-studio
    mangohud
    
    # hyprland and customization :p
    hyprshot
    hyprlock
    wofi
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

    # random things
    psmisc
    libnotify
    playerctl
    protonup-qt
    zsh-powerlevel10k
    pavucontrol
    pulseaudio

    # themes
    materia-theme
    bibata-cursors
    gruvbox-dark-gtk
    gruvbox-plus-icons
    gruvbox-dark-icons-gtk
    gruvbox-material-gtk-theme
    numix-solarized-gtk-theme

    #mmd tools and drivers
    radeontop
  ];

  # fontsa
  fonts.fonts = with pkgs; [
  plemoljp-nf

  nerd-fonts.comic-shanns-mono
  nerd-fonts.jetbrains-mono
  nerd-fonts.fira-code
  nerd-fonts.fira-mono
  fira-code
  nerd-fonts.hack
  nerd-fonts.iosevka
  nerd-fonts.victor-mono
  source-code-pro
  noto-fonts-cjk-sans
  noto-fonts-color-emoji
  rubik
  inter
  font-awesome
  corefonts
];

  # Optional Hyprland session
  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
  };

  # System version — do NOT change unless installing a fresh system
  system.stateVersion = "23.11";
}
