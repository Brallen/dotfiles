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
    wezterm
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
