alias ls='ls -G'
alias vim=nvim
alias nv=nvim
eval "$(starship init zsh)"

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

# Use bat to pretty print git diffs
bd() {
  git diff --name-only --relative --diff-filter=d -z | xargs --null bat --diff
}

# Add in the ssh key to the session
issh() {
  ssh-add ~/.ssh/github
}

export PATH=$HOME/.local/bin:$PATH
