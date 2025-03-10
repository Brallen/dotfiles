{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    bat
    fd
    fzf
    unstable.ghostty
    git
    lazygit
    unstable.neovim
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
