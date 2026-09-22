{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    bat
    fd
    fzf
    gcc # tree-sitter CLI needs a C compiler to build parsers
    unstable.ghostty
    git
    inotify-tools # for neovim file watching
    lazygit
    lua-language-server
    unstable.neovim
    ripgrep
    starship
    stow
    stylua
    tmux
    tree-sitter # nvim-treesitter (main branch) compiles parsers with the CLI
  ];

  programs = {
    zsh.enable = true;
  };

  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";
}
