
export EDITOR=nvim

alias ls='ls -G'
alias vim=nvim
alias nv=nvim
eval "$(starship init zsh)"

export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

