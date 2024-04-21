{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
     alejandra
     neovim
     git
     tmux
     ripgrep
     lazygit
     stow
     starship
     zsh
     neofetch
  ];

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
