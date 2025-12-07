{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

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
      theme = "powerlevel10k/powerlevel10k";
      plugins = [ "git" "z" "colored-man-pages" ];
    };
  };

environment.shellInit = ''
  [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
'';

environment.etc."zsh/p10k".source =
  "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";


  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
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

  # Allow unfree packages (Steam, Spotify, etc.)
  nixpkgs.config.allowUnfree = true;

  # System Packages
  # General applications
  environment.systemPackages = with pkgs; [
    kitty
    discord
    spotify
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
    kitty
    nemo
    micro
    cava
    cmatrix
    tty-clock

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

    # Amd tools and drivers
    radeontop
  ];

  # Optional Hyprland session
  programs.hyprland.enable = true;

  # System version — do NOT change unless installing a fresh system
  system.stateVersion = "23.11";
}
