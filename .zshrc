#!/usr/bin/env zsh
# vim: foldmethod=marker

# zsh configuration
# written by Zach Himsel, 2014-2016
# https://github.com/zhimsel/dotfiles

# This file is written with vim foldmarkers to enable easier viewing
# It's designed to be viewed/edited from within vim. Each section has
# fold markers at the beginning and end, so you can easily close each
# section to find what you're looking for

# General Settings {{{

# Source the machine-specific "pre-config" zshrc if it exists
if [ -f ~/.zshrc.prelocal ]; then
     source ~/.zshrc.prelocal
fi

if [[ -x $(which nvim) ]]; then # set text editor
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi

# Add ~/bin to $PATH
export PATH="$HOME/bin:$PATH"


# Path settings
setopt path_dirs
setopt extended_glob
setopt list_packed
setopt pushd_ignore_dups
setopt pushd_minus
setopt auto_cd
setopt auto_pushd

# History settings
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_verify

# Completion settings
setopt correct
unsetopt correct_all
unsetopt flow_control
setopt always_to_end
setopt complete_in_word
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'  # case/hyphen insensitive completion
zstyle ':completion:*' special-dirs true
# colors
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# caching
export ZSH_CACHE_DIR="$HOME/.zsh_cache"
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# }}}

# Plugins {{{

export ZPLUG_HOME="$HOME/.zsh/zplug"
source $ZPLUG_HOME/init.zsh

zplug "RobSis/zsh-completion-generator"
zplug "Tarrasch/zsh-autoenv"
zplug "zhimsel/zsh-git-prompt"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:3

if [ -f ~/.zplug.local ]; then
  source $HOME/.zplug.local
fi
zplug load

# }}}

# Autocomplete {{{

# base zsh autocompletion
fpath=(~/.zsh/custom-completions $fpath)
autoload -Uz compinit
compinit -u

# bash autocompletions
autoload -Uz bashcompinit
bashcompinit -i
if [ -f ~/.bash_complete ]; then
. ~/.bash_complete
fi

# aws autocompletions
if [ -f "$(which aws_completer)" ]; then
     complete -C $(which aws_completer) aws
fi

# }}}

# Keybinding Settings {{{

# vi mode
bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
export KETTIMEOUT=1
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey -a u undo
bindkey -sM vicmd '^[' '^G'
bindkey -rM viins '^X'
bindkey -M viins '^X,' _history-complete-newer \
                 '^X/' _history-complete-older \
                 '^X`' _bash_complete-word

# misc keybindings
bindkey -s '^e' 'cd ..\n' #go up a directory with ctrl-e

# }}}

# Aliases {{{

alias nodotf='unset GIT_DIR GIT_WORK_TREE'
alias dotf='export GIT_DIR=$HOME/.dotfiles_git GIT_WORK_TREE=$HOME'
alias dotfl='export GIT_DIR=$HOME/.dotfiles_git_local GIT_WORK_TREE=$HOME'
alias dot='GIT_DIR=$HOME/.dotfiles_git GIT_WORK_TREE=$HOME git'
alias tod='GIT_DIR=$HOME/.dotfiles_git GIT_WORK_TREE=$HOME tig'
alias toda='tod --all'
alias tods='tod status'
alias vidot='GIT_DIR=$HOME/.dotfiles_git GIT_WORK_TREE=$HOME vim'

if [[ -x $(which nvim) ]]; then
  alias vvim=$(which vim)
  alias vim='nvim'
  alias vi='nvim'
fi

alias s='sudo -HE'
alias se='sudoedit'
alias please='s $(fc -ln -1)'
alias history='fc -il 1'
alias h='history'

# Git
alias cg='cd $(git rev-parse --show-toplevel)'
alias tiga='tig --all'
alias tigs='tig status'
alias tigr='tig $(git rev-parse --abbrev-ref --symbolic-full-name @{u})'

# File/folder management
alias vmv='vim -c Renamer'
alias ll='ls -lh'
alias la='ls -lah'
alias ltr='ls -ltrh'
alias tree='tree -I .git'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'
alias -g ........='../../../../../../..'

# }}}

# Functions {{{

# Provide list of recent directories to switch to
cdir () { # {{{
  local target
  target=$(dirs -v | fzf | awk '{ print $1}')
  if [[ -n $target ]]; then cd ~$target; fi
} # }}}

# Make and open new directory
mkcd() { # {{{
  mkdir -p "$1" &&
  eval cd "\"\$$#\""
} # }}}

# Delete current directory
rmwd() { # {{{
  local current_dir
  current_dir=$(pwd)
  cd .. || exit 1
  rm -rf $current_dir
} # }}}

# Create new blank executable file
xtouch() { # {{{
  touch "$@" &&
  eval chmod +x "$@"
} # }}}

# Interactive renaming
imv() { # {{{
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
} # }}}

# Create new virtualenvs and fix existing ones
mkvenv() { # {{{
  if [[ -z $1 ]]; then "Please specify a python version and project name: mkvenv <2,3> [venv_name]"; return 1; fi
  if [[ -n $2 ]]; then venv_dir="$HOME/.venv/$2"; else venv_dir="$HOME/.venv/$(basename $(pwd))"; fi
  if [[ -n "$VIRTUAL_ENV" ]]; then echo "A virtualenv is active! Please run 'deactivate' first."; return 1; fi
  echo "Creating python${1} virtualenv for $(pwd) in $venv_dir"
  mkdir -p "$venv_dir" || return 1
  [[ -e "$venv_dir" ]] && find -L "$venv_dir" -type l -delete -print
  python${1} -m virtualenv -p "python${1}" "$venv_dir" || return 1
  source ${venv_dir}/bin/activate
  pip install --upgrade pip
  pip install --upgrade -r "$HOME/.pip_packages_base.txt"
  [[ -f .autoenv.zsh ]] || echo "source ${venv_dir}/bin/activate" > .autoenv.zsh
  [[ -f .autoenv_leave.zsh ]] || echo "deactivate" > .autoenv_leave.zsh
} # }}}

# Manage git worktrees
wt () { # {{{
  if [[ -z $1 ]]; then
    echo "Please specify the branch to check out"
    return 1
  else
    working_dir="$(pwd)"
    while true; do
      if [[ -f .git ]]; then  # already in a worktree
        cd "$(cat .git | cut -d' ' -f2)/../../.." || return 1
      elif [[ -d .git ]]; then  # in main worktree
        wt_path="../${0:A:h:t}.$1"
        break
      elif [[ "$(pwd)" == '/' ]]; then  # exhausted the whole dir tree
        echo "We don't seem to be in a git worktree"
        cd $working_dir
        return 1
      else  # walk up to the parent dir and try again
        cd ..
        continue
      fi
    done
    git worktree prune
    git branch "$1" &> /dev/null
    wt_add="$(git worktree add "$wt_path" "$1" 2>&1)"
    if [[ $wt_add =~ ^fatal.*already\ checked\ out.* ]]
    then  # if it's already checked out, go there
      cd "$(cut -d\' -f4  <<< "$wt_add")" || return 1
    else  # otherwise, go to the one we just made
      cd "$wt_path" || return 1
    fi
    unset working_dir wt_path wt_add
    return 0
  fi
} # }}}

wtr () { # {{{
  working_dir="$(pwd)"
  while true; do
    if [[ -f .git ]]; then
      if [[ "$(git status)" == *clean* ]]; then
        main_wt="$(cat .git | cut -d' ' -f2)/../../.."
        current_wt="${0:A:h}"
        cd "$main_wt" || return 1
        rm -rf "$current_wt" || return 1
        rm -rf "$main_wt/.git/worktrees/${current_wt:t}"
        git worktree prune
        return 0
      else
        echo "Your working directory is not clean! Stash or commit your changes before continuing."
        return 1
      fi
    elif [[ "$(pwd)" == '/' ]]; then
      echo "We don't seem to be in a git worktree"
      cd $working_dir
      return 1
    else
      cd ..
    fi
  done
} # }}}

# switch aws-vault profiles
aws-vault-use () { # {{{
  local profile output
  profile="$1"
  output="$(aws-vault exec "$profile" -- env)"
  if [[ $? -ne 0 ]]; then
    echo "$output" >&2
    return 1
  fi
  eval "$(echo "$output" | awk '/^AWS/ { print "export " $1 }')"
} # }}}

# }}}

# Visual/Theme Settings {{{

# set theme
ZSH_THEME=""

# Prompt Settings {{{
ZSH_THEME_GIT_PROMPT_NOCACHE="1"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[magenta]%}"
function precmd {
  local newline=$'\n'

  # build standard info line
  local user_name="%(!.%{$fg[red]%}.%{$fg[green]%})%n%{$reset_color%}"
  local host_name="%{$fg[yellow]%}%m%{$reset_color%}"
  local current_dir="%{$fg[blue]%}%~%{$reset_color%}"
  local current_time="%{$fg[lightgrey]%}%*%{$reset_color%}"
  local return_code="%(?..%{$fg[red]%}↳ %? %{$reset_color%})"

  # build metadata line, if any exists
  local git_status=$(git rev-parse --is-inside-work-tree &> /dev/null && echo "$(git_super_status) ")
  local py_venv=$(if [[ ! -z $VIRTUAL_ENV ]]; then echo "(venv:$(basename $VIRTUAL_ENV)) "; fi)
  local vbox_active=$(if [[ ! -z $(ls -H $HOME/.vbox_vms_dir/ 2>/dev/null) ]]; then echo "(vbox) "; fi)
  local aws_profile=$(if [[ ! -z $AWS_PROFILE ]]; then echo "(aws:${AWS_PROFILE}) "; fi)
  local aws_vault_profile=$(if [[ ! -z $AWS_VAULT ]]; then echo "(aws-vault:${AWS_VAULT}) "; fi)
  local env_metadata="${git_status}${py_venv}${vbox_active}${aws_profile}${aws_vault_profile}"
  if [[ ! -z $env_metadata ]]; then
     env_info="${newline}${env_metadata}"
  else
    env_info=""
  fi

  # command prompt itself
  local command_prompt="%(1j.%(!.%B[%j]%b #.%B[%j]%b $).%(!.#.$))"

  # put it all together
  PROMPT="${newline}${return_code}${current_time} ${user_name} at ${host_name} in ${current_dir}${env_info}${newline}${command_prompt} "
  RPROMPT=""
}
# }}}

# Show a different cursor for different vim modes {{{
function zle-keymap-select zle-line-init
{
    # change cursor shape in iTerm2
    if [[ $TMUX != "" ]]
    then
        case $KEYMAP in
            vicmd)      print -n -- "\033Ptmux;\033\E]50;CursorShape=0\C-G\033\\";;  # block cursor
            viins|main) print -n -- "\033Ptmux;\033\E]50;CursorShape=1\C-G\033\\";;  # line cursor
        esac
    else
        case $KEYMAP in
            vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
            viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
        esac
    fi

    zle reset-prompt
    zle -R
}

function zle-line-finish
{
    if [[ $TMUX != "" ]]
    then
        print -n -- "\033Ptmux;\033\E]50;CursorShape=0\C-G\033\\"
    else
        print -n -- "\E]50;CursorShape=0\C-G"
    fi
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
# }}}
# }}}

# Local Settings {{{

# load machine-specific options, should always be last to prevent clobbering
if [ -f ~/.zshrc.local ]; then
     source ~/.zshrc.local
fi

# }}}

# Load some stuff that needs to go last {{{

# make $PATH contain only unique elements
typeset -gU PATH path

# }}}
