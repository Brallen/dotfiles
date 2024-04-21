eval "$(starship init zsh)"
alias nv="nvim"

export PATH="$PATH:/opt/nvim-linux64/bin"
export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Delete all branches except for master
gbda() {
  git checkout master
  if [ $? -eq 0 ]; then
    git branch | grep -v "master" | xargs git branch -d
  fi
}

# Call into the NixOS rebuild switch faster
nrs() {
  ~/.dotfiles/nix/nixos-rebuild.sh
}
