# zsh configuration
# written by Zach Himsel, 2014-2015
# https://github.com/zhimsel/dotfiles


#############################################
# general settings
#############################################

umask 077 # set default umask
export EDITOR="vim" # set text editor


# set $PATH
export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin"
export PATH="$HOME/bin:$PATH"


# load oh-my-zsh and it's plugins
plugins=( \
          adb \
          brew \
          brew-cask \
          command-not-found \
          gem \
          git-extras \
          gnu-utils \
          knife \
          nmap \
          osx \
          pip \
          rails \
          screen \
          torrent \
          vagrant \
)
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh


# load normal zsh plugins
source ~/.zsh/opp.zsh/opp.zsh
source ~/.zsh/opp.zsh/opp/*.zsh
source ~/.zsh/berkshelf.zsh/berkshelf.plugin.zsh
source ~/.zsh/git-prompt.zsh/zshrc.sh


# setup autocomplete
autoload -Uz compinit
compinit

# load bash autocompletions
autoload -Uz bashcompinit
bashcompinit -i
if [ -f ~/.bash_complete ]; then
. ~/.bash_complete
fi

# load aws autocompletions
if [ -f "$(which aws_completer)" ]; then
     complete -C $(which aws_completer) aws
fi


# vi mode
bindkey -v
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line
export KETTIMEOUT=1
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey -a u undo
bindkey -a '^R' redo
bindkey -sM vicmd '^[' '^G'
bindkey -rM viins '^X'
bindkey -M viins '^X,' _history-complete-newer \
                 '^X/' _history-complete-older \
                 '^X`' _bash_complete-word


# misc keybindings
bindkey -s '^e' 'cd ..\n' #go up a directory with ctrl-e


# misc settings
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy.mm.dd"
setopt PATH_DIRS
setopt EXTENDED_GLOB
setopt LIST_PACKED
unsetopt CORRECT_ALL
setopt CORRECT
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt EXTENDED_HISTORY
MAILCHECK=0



#############################################
# aliases, functions, and modules
#############################################

# define aliases
alias please='sudo $(fc -ln -1)'
alias fucking='sudo'
alias la='ls -lah'
alias tree='tree -I .git'
alias h='history'


# make and open new directory
function mkcd () {
  mkdir -p "$1" &&
  eval cd "\"\$$#\""
}


# create new blank executable file
function xtouch () {
  touch "$@" &&
  eval chmod +x "$@"
}


# new cookbook function
newcook() {
  if [ $1 ] ; then
    git clone git@github.com:zhimsel/skeleton-cookbook.git $1
    cd $1; rm -rf .git/
    egrep -r "skeleton" * .kitchen.yml | cut -d ':' -f 1 | sort | uniq | xargs -n 1 sed -i '' "s/skeleton/$1/g"
  else
    echo "Need the name of the cookbook."
  fi
}


# create new chef-repo
newchef() {
  if [ $1 ] ; then
    git clone git@github.com:zhimsel/chef-repo.git $1-chef
    cd $1-chef; rm -rf .git/
    git init && git a .
  else
    echo "Need the name of the repo."
  fi
}


# interactive renaming
imv() {
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
}


# load zmv module
autoload -U zmv



#############################################
# visual/theme settings
#############################################

# set theme
ZSH_THEME=""


# prompt settings
ZSH_THEME_GIT_PROMPT_NOCACHE="1"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[magenta]%}"
if [[ -e "$(which cabal 2> /dev/null)" ]]; then GIT_PROMPT_EXECUTABLE="haskell"; fi
function precmd {
local user_name="%(!.%{$fg[red]%}.%{$fg[green]%})%n%{$reset_color%}"
local host_name="%{$fg[yellow]%}%m%{$reset_color%}"
local current_dir="%{$fg[blue]%}%~%{$reset_color%}"
local current_time="(%{$fg[lightgrey]%}%*%{$reset_color%})"
local rvm_status="(%{$fg[red]%}$(rvm-prompt)%{$reset_color%})"
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
PROMPT="${user_name} at ${host_name} in ${current_dir} ${current_time} $(git_super_status) ${rvm_status} ${return_code}
%(1j.%(!.%B[%j]%b #.%B[%j]%b $).%(!.#.$)) "
}
RPROMPT=""


# Show a different cursor for different vim modes
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



#############################################
# credential agent setup
#############################################

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



#############################################
# local settings
#############################################
#
# load machine-specific options, should always be last to prevent clobbering
if [ -f ~/.zshrc.local ]; then
     source ~/.zshrc.local
fi

