# General {{{

# Set neovim as the default editor
export EDITOR='nvim'
alias      vi=$EDITOR
alias     vim=$EDITOR

# ...and diff program
export DIFFPROG='nvim -d'
alias   vimdiff=$DIFFPROG

# ...and man pager
export MANWIDTH='999'
export MANPAGER='nvim -c "Man!"'

# Set default settings for shell utilities
export LESS="-R --mouse --wheel-lines=3 $LESS"
export AWS_PAGER="" # disable pager for output

# }}}

# History {{{

HISTFILE="${HISTFILE:-${ZSH_CACHE_DIR}/history}"
HISTSIZE=50000
SAVEHIST=50000

setopt extended_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_verify

# }}}

# Files/directories {{{

setopt auto_cd
setopt auto_pushd
setopt pushdsilent
setopt extended_glob
setopt list_packed
setopt path_dirs
setopt pushd_ignore_dups
setopt pushd_minus

# }}}

# vim-like commandline editing {{{

KEYTIMEOUT=20  # set key-sequence timeout in ms
bindkey -v  # enable vi mode
bindkey -M vicmd 'u' undo

# Make backspace/ctrl-w work like vim, not vi
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^W' backward-kill-word

# type 'v' in command mode to edit commandline in vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# }}}

# Set colors for `ls` if the tool is available {{{
[[ -x $(which dircolors) ]] && eval $(dircolors)
# }}}
