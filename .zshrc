#!/usr/bin/env zsh
# vim: foldmethod=marker

# This file is written with vim foldmarkers to enable easier viewing
# It's designed to be viewed/edited from within vim. Each section has
# fold markers at the beginning and end, so you can easily close each
# section to find what you're looking for

# Source machine-specific "pre-config" .zshrc {{{
source "$HOME/.zshrc.prelocal" &>/dev/null || true
# }}}

# Define a useful confirmation user prompt function {{{
confirm() {
  if read -q "?${1} [y/n] "; then
    echo ""; return 0
  else
    echo ""; return 1
  fi
} # }}}

# General Settings {{{

# History settings {{{
HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_verify
# }}}

# Cache settings {{{
ZSH_CACHE_DIR="$HOME/.zsh_cache"
# }}}

# vim-like commandline editing {{{
bindkey -v  # enable vi mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line  # type 'v' in normal mode to open commandline in vim
KEYTIMEOUT=20  # set key-sequence timeout in ms
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey -a u undo
bindkey -sM vicmd '^[' '^G'
bindkey -rM viins '^X'
bindkey -M viins '^X,' _history-complete-newer \
                 '^X/' _history-complete-older \
                 '^X`' _bash_complete-word
# }}}

# }}}

# Autocomplete {{{

# Set general completion settings {{{
setopt correct
unsetopt correct_all
unsetopt flow_control
setopt always_to_end
setopt complete_in_word
setopt complete_aliases
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'  # case/hyphen insensitive completion
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
# }}}

# include custom completions
fpath=("${HOME}/.zsh/custom-completions" $fpath)

# Init completion system {{{
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit
# }}}

# Use "upstream" completions for some wrapper programs
compdef tssh='ssh'

# }}}

# Plugins {{{

declare -A ZINIT
ZINIT[HOME_DIR]="$HOME/.zinit"
ZINIT[BIN_DIR]="${ZINIT[HOME_DIR]}/bin"

source "${ZINIT[BIN_DIR]}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice pick'zsh/fzf-zsh-completion.sh' ver'tmux-support'
zinit load "zhimsel/fzf-tab-completion"

zinit ice wait'!0'  # lazy-load until after prompt
zinit load "RobSis/zsh-completion-generator"

# `stack install` will fail if stack is not installed, will fall back to python implementation
zinit ice atpull'%atclone' atclone'stack install' pick'zshrc.sh'
zinit load "olivierverdier/zsh-git-prompt"

zinit ice wait'!0'  # lazy-load until after prompt
zinit load "zsh-users/zsh-completions"

source "$HOME/.zinit.local" &>/dev/null || true

# }}}

# File/folder management {{{

# Settings {{{
setopt path_dirs
setopt extended_glob
setopt list_packed
setopt pushd_ignore_dups
setopt pushd_minus
setopt auto_cd
setopt auto_pushd
# }}}

# Go up a directory with ctrl-e {{{
cd-up-widget() {
  cd ..
  zle reset-prompt
}
zle -N cd-up-widget
bindkey '^e' cd-up-widget
# }}}

# Aliases/keybinds {{{
alias tree='tree -I .git'
alias vmv='vim -c Renamer'
alias ls='ls --color=auto'  # enable color (if possible) for `ls`

# ls shortcuts
alias l='ls'
alias ll='ls -lh'
alias la='ls -lah'
alias ltr='ls -lhtr'
alias latr='ls -lahtr'
# }}}

cd- () { # {{{
  # Provide list of recent directories to switch to
  local target=$(dirs -v | awk '{ print $2}' |  fzf +m --preview 'tree -C {} | head -200')
  if [[ -n $target ]]; then cd $target; fi
} # }}}

mkcd() { # {{{
  # Make and open new directory
  mkdir -p "$1" &&
  eval cd "\"\$$#\""
} # }}}

rmwd() { # {{{
  # Delete current directory
  local current_dir
  current_dir=$(pwd)
  cd .. || exit 1
  confirm "Remove '$current_dir' and everything in it?" && rm -rf $current_dir || cd $current_dir
} # }}}

xtouch() { # {{{
  # Create new blank executable file
  touch "$@" &&
  eval chmod +x "$@"
} # }}}

imv() { # {{{
  # Interactively rename file(s)
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
} # }}}

# }}}

# All kinds of shortcuts {{{

# General laziness {{{
alias s='sudo -E'
alias se='sudo -e'
alias please='s $(fc -ln -1)'  # re-run last command with `sudo`
alias history='fc -il 1'
alias h='history'
alias htop='s htop'  # always use sudo so we can kill any process

# shortcut for cd'ing into ~/dev with autocomplete
dev() { cd "$HOME/dev/${1:-}" }
compdef '_files -/ -W $HOME/dev' dev
# }}}

# dotfile management {{{
alias nodot='unset GIT_DIR GIT_WORK_TREE'
alias dot='export GIT_DIR=$HOME/.dotfiles_git GIT_WORK_TREE=$HOME'
alias ldot='export GIT_DIR=$HOME/.dotfiles_git_local GIT_WORK_TREE=$HOME'

dotu () { # {{{
  nodot || return 1
  vim -c 'PlugUpgrade | PlugUpdate'
  zsh -ic "zinit update --all"  # run in new shell to pick up any plugin updates
} # }}}

# }}}

# Git {{{
alias cg='cd $(git rev-parse --show-toplevel)'  # cd to root of git repo
alias tiga='tig --all'
alias tigs='tig status'
alias tigr='tig $(git rev-parse --abbrev-ref --symbolic-full-name @{u})'  # open tig at remote tracking branch
alias wtl='git wtl'
alias wtp='git wtp'

wt () { # {{{
  # Create git worktrees
  [[ -z "$1" ]] && return 1
  local branch="$1"
  local prefix="$(git rev-parse --show-prefix)"
  local wt_path=$(git worktree list | awk -v branch="[$branch]" '$3==branch {print $1}')
  if [[ ! -d "$wt_path" ]]; then
    cd "$(git rev-parse --git-common-dir)/.." || return $?
    local wt_path="${2:-$(git rev-parse --show-toplevel).$branch}"
    if [[ ! -d "$wt_path" ]]; then
      git worktree prune
      git branch "$branch" &>/dev/null && echo "Created branch $branch"
      git worktree add "$wt_path" "$branch" || return $?
    fi
  fi
  cd "$wt_path/$prefix" || cd "$wt_path" || return $?
} # }}}

wtr () { # {{{
  # Remove git worktrees
  local wt_path="${1:-$(git rev-parse --show-toplevel)}"
  local wt_parent="$(realpath ${wt_path}/..)"
  [[ -z $1 ]] && { cd "$(git rev-parse --git-common-dir)/../$(git rev-parse --show-prefix)" \
    || cd "$(git rev-parse --git-common-dir)/.." \
    || return $? }
  git worktree remove "$wt_path"
  git worktree prune
  rmdir --ignore-fail-on-non-empty --parents "$wt_parent"
} # }}}

# }}}

# systemd {{{
alias sc='s systemctl'
alias scu='systemctl --user'
alias jc='s journalctl'
# }}}

# Terraform {{{
alias tf='terraform'
alias tfp='tf plan -out .tfplan'
alias tfa='tf apply .tfplan && rm -v .tfplan'
# }}}

# Arch Linux (uses `yay` AUR wrapper) {{{
alias pacman='s pacman'
alias pacdiff='s pacdiff'
alias pacs="yay -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro yay -S"  # fzf-based package search and install
alias pacman-rank-mirrors="s reflector --verbose --threads 20 --country 'United States' --country 'Canada' --protocol https --sort rate --age 24 --latest 100 --number 20 --save /etc/pacman.d/mirrorlist && yay -Syyu"
alias pacman-clean-orphans='echo "Found orphans:"; yay -Qqdt; echo; yay -Runs $(yay -Qqdt)'
# }}}

# AWS {{{

# switch aws-vault profiles
av () { # {{{
  local profile output
  profile="$1"
  [[ -z $AWS_VAULT ]] || unset AWS_VAULT
  output="$(aws-vault exec "$profile" -- env)"
  if [[ $? -ne 0 ]]; then
    echo "$output" >&2
    return 1
  fi
  eval "$(echo "$output" | awk '/^AWS/ { print "export " $1 }')"
} # }}}

# switch aws profiles
ap () { # {{{
  export AWS_PROFILE="$1"
  export AWS_DEFAULT_PROFILE="$1"
} # }}}

# }}}

# Docker {{{
alias docker='s docker'
alias dc='s docker-compose'
# }}}

# Kubernetes (k8s) {{{
alias k='kubectl'
kc() { k config use-context "$1" }
# }}}

# }}}

# Visual/appearance settings {{{

# Prompt Settings {{{

# git-super-status settings
[[ -x $(which stack) ]] && GIT_PROMPT_EXECUTABLE="haskell"
ZSH_THEME_GIT_PROMPT_NOCACHE="1"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[magenta]%}"

# Color-code anything with "prod" red
function _color_prod_red () {
  if [[ "$1" =~ "prod" ]]; then
    echo "%{$fg[red]%}$1%{$reset_color%}"
  else
    echo "$1"
  fi
}

# Put prompt in precmd() so it refreshes every time it loads
function precmd {
  local newline=$'\n'  # convenience var

  # standard info line {{{
  local -a prompt_info
  prompt_info+=("%(!.%{$fg[red]%}.%{$fg[green]%})%n%{$reset_color%}")  # username (color-coded for root)
  prompt_info+=("on %{$fg[yellow]%}%m%{$reset_color%}")  # hostname
  prompt_info+=("at %{$fg[cyan]%}%*%{$reset_color%}")  # current time
  prompt_info+=("in %{$fg[blue]%}%~%{$reset_color%}")  # current working directory
  # }}}

  # metadata line, if any exists {{{
  local -a prompt_metadata
  git rev-parse --is-inside-work-tree &> /dev/null && prompt_metadata+=("git:$(git_super_status)")
  prompt_metadata+=(${VIRTUAL_ENV:+"venv:($(basename ${VIRTUAL_ENV}))"})
  prompt_metadata+=(${AWS_PROFILE:+"aws:($(_color_prod_red ${AWS_PROFILE}))"})
  prompt_metadata+=(${AWS_VAULT:+"aws-vault:($(_color_prod_red ${AWS_VAULT}))"})
  local k8s_context=$(kubectl config current-context 2>/dev/null); prompt_metadata+=(${k8s_context:+"k8s:($(_color_prod_red ${k8s_context}))"})
  # }}}

  # command prompt line {{{
  local _return_code="%(?::%{$fg[red]%}↳ %? %{$reset_color%})"
  local _jobs="%(1j:%B[%j]%b :)"
  local prompt_command="${_return_code}${_jobs}%(!:#:$) "
  # }}}

  # put it all together {{{
  PROMPT="${newline}${prompt_info}${newline}${prompt_metadata}${prompt_metadata:+$newline}${prompt_command}"
  RPROMPT=""
  # }}}
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

# Set colors for `ls` if the tool is available {{{
[[ -x $(which dircolors) ]] && eval $(dircolors)
# }}}

# }}}

# Source machine-specific .zshrc almost-last (to allow overriding anything in this file) {{{
source "$HOME/.zshrc.local" &>/dev/null || true
# }}}

# FZF settings {{{
# Must be loaded after .zshrc.local since FZF completions and keybindings are sourced there

# Only set these if fzf is actually loaded
if which __fzfcmd >/dev/null; then

  # Don't use tmux panes (performance issues)
  export FZF_TMUX=1
  export FZF_TMUX_HEIGHT='60%'

  # Set default options
  export FZF_DEFAULT_OPTS='-m --height=40% --reverse -0 -1 --ansi'
  export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"  # enable file preview
  export FZF_CTRL_R_OPTS="--no-sort --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"  # press ? to show truncated results
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"  # show folder preview

  # Create "git-files" widget and binding
  fzf-git-file-widget() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
      FZF_CTRL_T_COMMAND='git ls-files' fzf-file-widget
    fi
  }
  zle -N fzf-git-file-widget
  bindkey '^G' fzf-git-file-widget

  # Use tab-tab to use fzf for all arg completions
  export FZF_COMPLETION_TRIGGER=''  # turn off '**' completion
  bindkey '^I' expand-or-complete  # default zsh completion
  bindkey '^I^I' fzf_completion  # completion piped through fzf

  # Set fzf-tab-completion options
  zstyle ':completion:*' fzf-search-display true  # search display-strings by default
  zstyle ':completion:complete:*:options' sort false # disable sort when completing options of any command
fi

# }}}

# set up direnv hook {{{
if [[ -x $(which direnv) ]]; then
  eval "$(direnv hook zsh)"
  alias tmux='direnv exec / tmux'  # unload direnv before running tmux to avoid subshell complications
fi
# }}}

zinit load "zsh-users/zsh-syntax-highlighting"

# Source machine-specific "post-config" .zshrc actually-last (to allow overriding anything after .zshrc.local) {{{
source "$HOME/.zshrc.postlocal" &>/dev/null || true
# }}}
