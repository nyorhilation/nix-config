# shell configuration

{ config, pkgs, ...}:

{
  # shell
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
  
    # p10k prompt
    environment.etc."zsh/p10k.zsh".source =
      "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
}
