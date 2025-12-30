# themes, fonts and icon packages

{ pkgs, ...}:

{ # themes
  environment.systemPackages = with pkgs; [
    materia-theme
    bibata-cursors
    gruvbox-dark-gtk
    gruvbox-plus-icons
    gruvbox-dark-icons-gtk
    gruvbox-material-gtk-theme
    whitesur-icon-theme
    tokyonight-gtk-theme
  ];

  # fonts
  fonts.packages = with pkgs; [
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

}
