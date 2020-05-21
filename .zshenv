# vim: foldmethod=marker

# Set special envar types and remove duplicate entries {{{
typeset -gxU path
typeset -gxU manpath
typeset -gxU fpath
# }}}

# Load machine-specific .zshenv {{{
# This goes first because it usually contains machine-specific PATHs
source "$HOME/.zshenv.local" &>/dev/null || true
# }}}

# Set neovim as the default editor {{{
export EDITOR='nvim'
alias      vi=$EDITOR
alias     vim=$EDITOR

export DIFFPROG='nvim -d'
alias   vimdiff=$DIFFPROG

# }}}

# Set default settings for shell utilities {{{
export LESS="-R --mouse --wheel-lines=3 $LESS"
export MANWIDTH='999'
export MANPAGER='nvim -c "Man!"'
# }}}

# Set XDG variables, if not already set {{{
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
# }}}

# Add ~/bin [mostly] last to allow overriding any system-installed executables
path=("$HOME/bin" $path)
