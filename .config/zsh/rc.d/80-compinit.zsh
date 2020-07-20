autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit

# Set some custom compdefs
compdef tssh='ssh'
compdef '_files -/ -W $HOME/dev' dev

# This should be loaded after compinit
zinit light "zsh-users/zsh-syntax-highlighting"
