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
