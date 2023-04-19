# Set directory variables
declare -A ZINIT
ZINIT[HOME_DIR]="${ZSH_DATA_DIR}/zinit"
ZINIT[BIN_DIR]="${ZINIT[HOME_DIR]}/bin"

# Load zinit
source "${ZINIT[BIN_DIR]}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load plugins

zinit ice pick'zsh/fzf-zsh-completion.sh'
zinit light "lincheney/fzf-tab-completion"

zinit light "RobSis/zsh-completion-generator"

zinit ice pick'spaceship.zsh'
zinit light "spaceship-prompt/spaceship-prompt"
zinit light "spaceship-prompt/spaceship-vi-mode"

zinit light "zsh-users/zsh-completions"
