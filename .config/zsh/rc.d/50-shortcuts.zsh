# General laziness {{{

alias s='sudo -E'
alias se='sudo -e'
alias please='s $(fc -ln -1)'  # re-run last command with `sudo`
alias history='fc -il 1'
alias h='history'
alias htop='s htop'  # always use sudo so we can kill any process

# }}}

# File/folder management {{{

alias tree='tree -I .git'
alias vmv='vim -c Renamer'
alias ls='ls --color=auto'  # enable color (if possible) for `ls`

# ls shortcuts
alias    l='ls'
alias   ll='ls -lh'
alias   la='ls -lha'
alias  ltr='ls -lhtr'
alias latr='ls -lahtr'

# }}}

# Dotfile management {{{
alias nodot='unset  GIT_DIR                           GIT_WORK_TREE'
alias   dot='export GIT_DIR=$HOME/.git_dotfiles       GIT_WORK_TREE=$HOME'
alias  ldot='export GIT_DIR=$HOME/.git_dotfiles_local GIT_WORK_TREE=$HOME'

# Open vim and start searching for dotfiles to edit.
# Do this in a subshell so you can change to the home dir and 'activate' git
# without changing anything about the parent shell.
alias  dote='(cd $HOME && vim -c  "Dot" -c "autocmd User VeryLazy Telescope git_files")'
alias ldote='(cd $HOME && vim -c "Ldot" -c "autocmd User VeryLazy Telescope git_files")'

# }}}

# Git {{{

alias cg='cd $(git rev-parse --show-toplevel)'  # cd to root of git repo
alias pwdg='git rev-parse --show-toplevel'  # pwd the root of git repo
alias tiga='tig --all'
alias tigs='tig status'
alias tigr='tig $(git rev-parse --abbrev-ref --symbolic-full-name @{u})'  # open tig at remote tracking branch
alias wtl='git wtl'
alias wtp='git wtp'

# Github
alias gh-pr-urls="gh search prs --json url --jq '.[].url'"

# }}}

# systemd {{{

alias sc='s systemctl'
alias scu='systemctl --user'

alias jc='s journalctl'

# }}}

# Terraform {{{

alias tf='terraform'
alias tfi='tf init'
alias tfp='tf plan -out .tfplan'
alias tfpnr='tfp -refresh=false'
alias tfip='tfi && tfp'
alias tfa='tf apply .tfplan && rm -v .tfplan'
alias tfia='tfi && tfa'
alias tfr='tf refresh'

# }}}

# Arch Linux (uses `yay` AUR wrapper) {{{

alias pacman='s pacman'
alias pacdiff='s pacdiff'
alias pacs="yay -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro yay -S"  # fzf-based package search and install
alias pacman-rank-mirrors="s reflector --verbose --country 'United States' --protocol https --sort rate --age 24 --latest 15 --number 5 --save /etc/pacman.d/mirrorlist"
alias pacman-clean-orphans='echo "Found orphans:"; yay -Qqdt && echo; yay -Runs $(yay -Qqdt)'

# }}}

# Docker {{{

alias dc='docker-compose'

# }}}

# Kubernetes {{{

alias kg='k config use-context' # "kube global"
kc() {
  [[ -n "$1" ]] && export KUBE_CONTEXT="$1" || unset KUBE_CONTEXT
  [[ -n "$2" ]] && export KUBE_NAMESPACE="$2"
}
kn() { [[ -n "$1" ]] && export KUBE_NAMESPACE="$1" || unset KUBE_NAMESPACE }

alias k='kubectl ${=KUBE_CONTEXT:+--context ${KUBE_CONTEXT}} ${=KUBE_NAMESPACE:+-n ${KUBE_NAMESPACE}}'
alias helm='helm ${=KUBE_CONTEXT:+--kube-context ${KUBE_CONTEXT}} ${=KUBE_NAMESPACE:+-n ${KUBE_NAMESPACE}}'

# Lazy
# alias k='kubectl'
alias kx='kubectx'
# }}}

# MacOS {{{
alias dns-clear-cache='dscacheutil -q dns'
alias dns-list-resolvers='scutil --dns'
# }}}
