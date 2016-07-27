# bash configuration file
# written by Zach Himsel, 2013,2015
# https://github.com/zhimsel/dotfiles


###########################################
# basic settings
###########################################

# if not running interactively, do nothing
[[ $- != *i* ]] && return

umask 077 # set default permissions
export LANG="en_US.UTF8" # set locale to UTF8
export EDITOR=vim # set default editor

# append to the history file, don't overwrite it
export HISTTIMEFORMAT="%F %T "
HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups
history() {
  _bash_history_sync
  builtin history "$@"
}
_bash_history_sync() {
  builtin history -a         #1
  HISTFILESIZE=$HISTSIZE     #2
  builtin history -c         #3
  builtin history -r         #4
}
PROMPT_COMMAND=_bash_history_sync

# set up $PATH
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
pathadd ~/bin
pathadd ~/.cabal/bin
pathadd ~/.rvm/bin # Add RVM to PATH for scripting


###########################################
# Aliases and functions
###########################################

alias vi=vim
alias fucking="sudo"
alias please="sudo !!"
alias cdd="cd $OLDPWD"
alias cls="clear"
alias sc="systemctl"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# enable color support of ls/grep and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -lah'

alias py='python' # alias py to python

# get external IP address
alias ipecho='wget -qO- http://ipecho.net/plain ; echo'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Source extrenal bash_aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi



###########################################
# Visual settings (prompt, etc)
###########################################

# Set prompt
PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \W \$\[\033[00m\] "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac



###########################################
# Autocompletion settings
###########################################

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# source user's bash_complete (if it exists)
if [ -f ~/.bash_complete ]; then
. ~/.bash_complete
fi

# set up AWS completions
if [ -f $(which aws_completer) ]; then
     complete -C $(which aws_completer) aws
fi



###########################################
# Agent settings
###########################################

# Set up SSH agent
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


###########################################
# Local configuration
###########################################

# source local config if it exists
if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi
