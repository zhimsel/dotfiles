# set default umask
umask 077


# set $PATH
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export PATH="$PATH:$HOME/bin"


# theme
ZSH_THEME="bira"


# oh-my-zsh settings
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
plugins=(git ruby aws gem jsontools nyan pip sublime sudo systemd apt yum common-aliases bundler command-not-found rvm rails) 


# load machine-specific options
if [ -f ~/.zshrc-local ]; then
     source ~/.zshrc-local
fi


# misc settings
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy.mm.dd"


#set text editor
export EDITOR="vim"
bindkey -v
export KETTIMEOUT=1


# set syntax hightlighting
export HIGHLIGHT_FILE="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f "$HIGHLIGHT_FILE" ]; then
     source "$HIGHLIGHT_FILE"
fi


# load bash completions
autoload bashcompinit
bashcompinit

if [ -f ~/.bash_complete ]; then
. ~/.bash_complete
fi

if [ -f "$(which aws_completer)" ]; then
     complete -C $(which aws_completer) aws
fi


# aliases
alias please='sudo $(fc -ln -1)'
alias sc="systemctl"
alias la="ls -lah"
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }


# gpg-agent setup
export GPGKEY=F7D2C279

# ssh-agent setup
env=~/.ssh/agent.env

agent_is_running() {
    if [ "$SSH_AUTH_SOCK" ]; then
        # ssh-add returns:
        #   0 = agent running, has keys
        #   1 = agent running, no keys
        #   2 = agent not running
        ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
    else
        false
    fi
}

agent_has_keys() {
    ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
    . "$env" >/dev/null
}

agent_start() {
    (umask 077; ssh-agent >"$env")
    . "$env" >/dev/null
}

if ! agent_is_running; then
    agent_load_env
fi

if ! agent_is_running; then
    agent_start
    ssh-add
elif ! agent_has_keys; then
    ssh-add
fi

unset env
