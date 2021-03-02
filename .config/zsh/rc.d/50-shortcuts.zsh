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

# Go up a directory with ctrl-e {{{

cd-up-widget() {
  cd ..
  vcs_info
  zle reset-prompt
}
zle -N cd-up-widget

bindkey -M viins '^e' cd-up-widget
bindkey -M vicmd '^e' cd-up-widget

# }}}

# }}}

# Dotfile management {{{
alias nodot='unset  GIT_DIR                           GIT_WORK_TREE'
alias   dot='export GIT_DIR=$HOME/.git_dotfiles       GIT_WORK_TREE=$HOME'
alias  ldot='export GIT_DIR=$HOME/.git_dotfiles_local GIT_WORK_TREE=$HOME'

alias  dote=' dot && nvim -c "cd $HOME" -c  Dot -c GitFiles'
alias ldote='ldot && nvim -c "cd $HOME" -c Ldot -c GitFiles'

# }}}

# Git {{{

alias cg='cd $(git rev-parse --show-toplevel)'  # cd to root of git repo
alias tiga='tig --all'
alias tigs='tig status'
alias tigr='tig $(git rev-parse --abbrev-ref --symbolic-full-name @{u})'  # open tig at remote tracking branch
alias wtl='git wtl'
alias wtp='git wtp'

# }}}

# systemd {{{

alias sc='s systemctl'
alias scu='systemctl --user'

alias jc='s journalctl'

# }}}

# Terraform {{{

alias tf='terraform'
alias tfr='tf refresh'
alias tfp='tf plan -out .tfplan'
alias tfpnr='tfp -refresh=false'
alias tfa='tf apply .tfplan && rm -v .tfplan'

# }}}

# Arch Linux (uses `yay` AUR wrapper) {{{

alias pacman='s pacman'
alias pacdiff='s pacdiff'
alias pacs="yay -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro yay -S"  # fzf-based package search and install
alias pacman-rank-mirrors="s reflector --verbose --country 'United States' --country 'Canada' --protocol https --sort rate --age 24 --latest 100 --number 20 --save /etc/pacman.d/mirrorlist && yay -Syu"
alias pacman-clean-orphans='echo "Found orphans:"; yay -Qqdt; echo; yay -Runs $(yay -Qqdt)'

# }}}

# Docker {{{

alias docker='s docker'
alias dc='s docker-compose'

# }}}

# Kubernetes {{{

alias k='kubectl ${=KUBE_CONTEXT:+--context ${KUBE_CONTEXT}} ${=KUBE_NAMESPACE:+-n ${KUBE_NAMESPACE}}'
alias kc='k config use-context'
kcl() { [[ -n "$1" ]] && export KUBE_CONTEXT="$1" || unset KUBE_CONTEXT }
kn () { [[ -n "$1" ]] && export KUBE_NAMESPACE="$1" || unset KUBE_NAMESPACE }

# }}}
