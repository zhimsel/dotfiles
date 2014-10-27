# set $PATH
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export PATH="$PATH:$HOME/bin"

# theme
ZSH_THEME="bira"

# oh-my-zsh settings
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
plugins=(git ruby aws gem jsontools nyan pip sublime sudo systemd apt yum common-aliases bundler command-not-found rvm rails) 


# misc settings
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy.mm.dd"

#set text editor
export EDITOR='vim'

# set syntax hightlighting
export HIGHLIGHT_FILE="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f "$HIGHLIGHT_FILE" ]; then
     source "$HIGHLIGHT_FILE"
fi
