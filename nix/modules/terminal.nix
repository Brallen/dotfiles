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
  ];

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
