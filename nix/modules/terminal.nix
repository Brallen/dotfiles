{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
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
