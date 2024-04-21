{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    git
    lazygit
    neofetch
    neovim
    ripgrep
    stow
    starship
    tmux
    zsh
  ];

  programs.zsh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
