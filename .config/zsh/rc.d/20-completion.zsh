setopt   always_to_end
setopt   complete_in_word
setopt   correct
unsetopt correct_all
unsetopt flow_control

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'  # case/hyphen insensitive completion
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# include custom completions
fpath=("${ZSH_CONFIG_DIR}/completions" $fpath)
