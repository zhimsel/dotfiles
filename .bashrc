#!/usr/bin/env bash

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

source ~/.git-subrepo/.rc

###########################################
# Aliases and functions
###########################################

function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# some more ls aliases
alias ll='ls -lh'
alias la='ls -lah'


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
# Local configuration
###########################################

# source local config if it exists
if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi
