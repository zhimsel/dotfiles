# Spaceship Prompt Settings {{{

SPACESHIP_USER_COLOR="green"

SPACESHIP_HOST_COLOR="yellow"
SPACESHIP_HOST_COLOR_SSH="yellow"

SPACESHIP_DIR_COLOR="blue"
SPACESHIP_DIR_TRUNC_PREFIX="…/"

SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_STATUS_DIVERGED="⇡⇣"

SPACESHIP_EXEC_TIME_PREFIX="took "

SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_SYMBOL="↳ "

SPACESHIP_JOBS_SYMBOL=""
SPACESHIP_JOBS_COLOR="yellow"
SPACESHIP_JOBS_AMOUNT_PREFIX="["
SPACESHIP_JOBS_AMOUNT_SUFFIX="]"
SPACESHIP_JOBS_AMOUNT_THRESHOLD=0

SPACESHIP_VI_MODE_INSERT="❯"
SPACESHIP_VI_MODE_NORMAL="❮"
SPACESHIP_VI_MODE_COLOR="green"
spaceship_vi_mode_enable

SPACESHIP_PROMPT_ORDER=(
  user
  host
  dir
  git
  exec_time

  line_sep

  exit_code
  jobs
  vi_mode
)

# Remove bold from prompt (this no longer works in v4+)
# https://github.com/spaceship-prompt/spaceship-prompt/issues/426
# () {
#   local z=$'\0'
#   PROMPT='${${${$(spaceship::prompt)//\%\%/'$z'}//\%B}//'$z'/%%}'
# }

# }}}

# Go up a directory with ctrl-e {{{

cd-up-widget() {
  cd ..
  spaceship::core::refresh_section --sync git
  spaceship::core::refresh_section --sync dir
}
zle -N cd-up-widget

bindkey -M viins '^e' cd-up-widget
bindkey -M vicmd '^e' cd-up-widget

# }}}

# Type alt-e to display useful env metadata {{{

prompt-metadata-widget() {
  zle -M "${(j: :)${(@eoni)PROMPT_METADATA}}"
}
zle -N prompt-metadata-widget

bindkey -M viins '^[e' prompt-metadata-widget
bindkey -M vicmd '^[e' prompt-metadata-widget

# To add things to the metadata output, just append a string to the array.
# Single-quote to expand parameters at runtime; double-quote to expand at shell creation.
typeset -agxU PROMPT_METADATA

PROMPT_METADATA+=('aws:(${AWS_PROFILE:-${AWS_DEFAULT_PROFILE}})')
PROMPT_METADATA+=('aws-vault:(${AWS_VAULT})')
PROMPT_METADATA+=('tf:($(terraform workspace show))')
PROMPT_METADATA+=('k8s:(${KUBE_CONTEXT:-$(kubectl config current-context 2>/dev/null)}${KUBE_NAMESPACE:+/${KUBE_NAMESPACE}})')
PROMPT_METADATA+=('venv:(${VIRTUAL_ENV})')

# }}}

# Type alt-d to display current working dir {{{

prompt-pwd-widget() {
  zle -M "$(pwd)"
}
zle -N prompt-pwd-widget

bindkey -M viins '^[d' prompt-pwd-widget
bindkey -M vicmd '^[d' prompt-pwd-widget

# }}}

# Type alt-g to display current git status {{{

git-status-widget() {
  zle -M "$(git status | sed 's/\t/        /')"
}
zle -N git-status-widget

bindkey -M viins '^[g' git-status-widget
bindkey -M vicmd '^[g' git-status-widget

# }}}
