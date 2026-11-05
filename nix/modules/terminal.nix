{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    bat
    fd
    fzf
    gcc # tree-sitter CLI needs a C compiler to build parsers
    unstable.ghostty
    unstable.helix
    inotify-tools # for neovim file watching
    jq # ~/.claude/sync-settings.sh and the Claude status line parse JSON
    lazygit
    lua-language-server
    ripgrep
    starship
    stow
    stylua
    tmux
    tree-sitter # nvim-treesitter (main branch) compiles parsers with the CLI
  ];

  programs = {
    git.enable = true;

    neovim = {
      enable = true;
      package = pkgs.unstable.neovim;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    # NH_FLAKE points here, so nh works from any directory:
    #   nh os switch              rebuild and switch (old nrs)
    #   nh os switch --update     update flake.lock, then switch (old nfu)
    #   nh os build [--update]    preview the package diff without activating
    #   nh os test                activate without adding a boot entry
    #   nh search <pkg>           search nixpkgs
    nh = {
      enable = true;
      flake = "/home/bart/.dotfiles/nix";
    };

    zsh = {
      enable = true;
      # Functions rather than shellAliases: an alias named nrs would break
      # parsing of any leftover `nrs() {...}` in a stowed ~/.zshrc.
      interactiveShellInit = ''
        # Flakes ignore untracked files, so intent-to-add new modules first
        nrs() {
          (cd ~/.dotfiles/nix && nix fmt && git add -N . && nh os switch)
        }

        nfu() {
          (cd ~/.dotfiles/nix && nh os switch --update \
            && git commit flake.lock -m "flake update: $(date -I)")
        }
      '';
    };
  };

  environment.variables.VISUAL = "nvim";
}
