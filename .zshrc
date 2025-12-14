
export EDITOR=nvim

alias ls='ls -G'
alias vim=nvim
alias nv=nvim
eval "$(starship init zsh)"

export PATH="$PATH:/opt/nvim-linux64/bin"

# Call into the NixOS rebuild switch faster
nrs() {
  ~/.dotfiles/nix/nixos-rebuild.sh
}

# Call into the NixOS update with flake faster

nfu() {
  ~/.dotfiles/nix/nixos-flake-update.sh
}

# Open the nix shell with zsh instead of bash
nd() {
  nix develop -c zsh
}

# Delete all branches except for master
gbda() {
  git checkout master
  if [ $? -eq 0 ]; then
    git branch | grep -v "master" | xargs git branch -d
  fi
}

# use bat to pretty print git diffs
bd() {
  git diff --name-only --relative --diff-filter=d -z | xargs --null bat --diff
}

export PATH=$HOME/.local/bin:$PATH
