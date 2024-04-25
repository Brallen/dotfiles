{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    fd
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

  programs = {
    zsh.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
