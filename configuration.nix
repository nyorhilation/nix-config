{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];


  # activate flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname & networking
  networking.hostName = "kamishiro";
  networking.networkmanager.enable = true;

  # Time
  time.timeZone = "America/Fortaleza";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Plasma + X11
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  console.keyMap = "br-abnt2";

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

	#powerlevel10k prompt
	environment.etc."zsh/p10k.zsh".source =
	  "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	  
	environment.shellInit = ''
   	  # Load Powerlevel10k theme
  	  source /etc/zsh/p10k.zsh
  	  
	  # Load Powerlevel10k personal config if it exists
	  [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
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

  # opengl drivers
  hardware.opengl = {
    enable = true;
  };
      
  # Users
  users.users.nora = {
    isNormalUser = true;
    description = "nora";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "power" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Firefox
  programs.firefox.enable = true;

  #thunar
  programs.thunar.enable = true;

  # Allow unfree packages (Steam, Spotify, etc.)
  nixpkgs.config.allowUnfree = true;

  # System Packages
  # General applications
  environment.systemPackages = with pkgs; [

    # spotify and spicetify
	spotify    

    # terminal
    kitty

    # apps
    vesktop
    pywalfox-native
    nwg-look
    vscode
    krita
    nwg-displays
    google-chrome
    obs-studio
    
    # Hyprland and customization :p
    hyprshot
    hyprlock
    waybar
    rofi
    pywal
    micro
    cava
    cmatrix
    tty-clock
    mako
    fastfetch
    git
    gh
    unzip
    swww
    wl-clipboard

    # Random things
    psmisc
    libnotify
    playerctl
    protonup-qt
    zsh-powerlevel10k

    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hack
    nerd-fonts.iosevka
    nerd-fonts.victor-mono
    source-code-pro

    #themes
    materia-theme
    bibata-cursors
    gruvbox-dark-gtk
    gruvbox-plus-icons
    gruvbox-dark-icons-gtk
    gruvbox-material-gtk-theme
    numix-solarized-gtk-theme

    # Amd tools and drivers
    radeontop
  ];

  # Optional Hyprland session
  programs.hyprland.enable = true;

  # System version — do NOT change unless installing a fresh system
  system.stateVersion = "23.11";
}
