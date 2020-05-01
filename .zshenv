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
export EDITOR="nvim"
alias      vi='nvim'
alias     vim='nvim'
alias vimdiff='nvim -d'
# }}}

# Set default settings for shell utilities {{{
export LESS="-R --mouse --wheel-lines=3 $LESS"
# }}}

# Add ~/bin [mostly] last to allow overriding any system-installed executables
path=("$HOME/bin" $path)
