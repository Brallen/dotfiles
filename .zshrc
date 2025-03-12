# Make sure Homebrew is running
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=$(brew --prefix openssh)/bin:$PATH
export PATH=/usr/local/bin:$PATH

export EDITOR=nvim

alias ls='ls -G'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias lsql='psql --username mercury-web-backend -d mercury-web-backend-development'
alias vim=nvim
alias nv=nvim
eval "$(starship init zsh)"

# Activate `fnm`: https://github.com/Schniz/fnm
if command -v fnm >/dev/null; then
    eval "$(fnm env --use-on-cd)"
fi

# Activate `direnv`: https://direnv.net/
if command -v direnv >/dev/null; then
    eval "$(direnv hook zsh)"
fi

autoload -Uz compinit && compinit

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Rust stuff
export PATH="$PATH:$HOME/.cargo/bin"

# Handy Aliases
# Make sure ssh agent is set up
issh() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/hobbes_14_dev
}

# Go to mercury FE repo from a fresh terminal
mw() {
  cd ~/Documents/repos/mercury-web
}

# Go to mercury BE repo from a fresh terminal
mwb() {
  cd ~/Documents/repos/mercury-web-backend
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

# Use Mercury Bootstrap to update environments
bootstrap() {
  nix run git+ssh://git@github.com/MercuryTechnologies/bootstrap-mercury.git
}

# Common dev command for the BE
mgw() {
  make ghciwatch watch_tags=1 watch_clear=1
}

# Source the FE .env so I don't keep manually doing it
if [[ -f "$HOME/Documents/repos/mercury-web/.envrc" ]]; then
  . "$HOME/Documents/repos/mercury-web/.envrc"
fi

# Source the Nix environment.
if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
elif [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Zed haskell stuff that might need to change
export PATH="$HOME/bin:$PATH"
add_to_path() {
    for pattern in "$@"; do
        # Find directories matching the pattern and add them to the PATH
        for dir in /nix/store/*$pattern*/bin; do
            if [[ -d "$dir" ]]; then
                export PATH="$dir:$PATH"
            fi
        done
    done
}
add_to_path "-prepare-cabal" "-modified-files" "-run-format"
