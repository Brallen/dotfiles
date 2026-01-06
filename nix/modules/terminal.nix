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
    lua-language-server
    unstable.neovim
    ripgrep
    starship
    stow
    stylua
    tmux
  ];

  programs = {
    zsh.enable = true;
  };

  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";
}
