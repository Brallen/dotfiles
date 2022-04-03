alias ls='ls -G'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
#this sets the path for Haskell to use
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$HOME/Library/apache-maven-3.5.2/bin:$PATH"
export PATH="/usr/local/bin/pip:$PATH"
export PATH="/Users/hobbes/Library/Python/3.6/bin:$PATH"
eval "$(oh-my-posh init zsh --config ~/.custom.omp.json)"
