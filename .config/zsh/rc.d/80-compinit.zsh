autoload -Uz +X compinit \
  && compinit
autoload -Uz +X bashcompinit \
  && bashcompinit

# This should be loaded after compinit
zinit light "zsh-users/zsh-syntax-highlighting"
