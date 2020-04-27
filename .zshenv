# vim: foldmethod=marker

# This file is written with vim foldmarkers to enable easier viewing
# It's designed to be viewed/edited from within vim. Each section has
# fold markers at the beginning and end, so you can easily close each
# section to find what you're looking for

# Set special envar types and remove duplicate entries
typeset -gxU path
typeset -gxU manpath
typeset -gxU fpath

# Load machine-specific .zshenv
# This goes first because it usually contains machine-specific PATHs
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local" || true

# Set [neo]vim as the default editor {{{
alias vi='vim'
if [[ -x $(which nvim) ]]; then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi
# }}}

# Set some default settings for `less`
export LESS="-R --mouse --wheel-lines=3 $LESS"

# Add ~/bin [mostly] last to allow overriding any system-installed executables
path=("$HOME/bin" $path)
