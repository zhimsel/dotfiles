# Set XDG variables, if not already set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Set base paths for all zsh config files
export ZSH_CONFIG_DIR="${XDG_CONFIG_HOME}/zsh"
export ZSH_DATA_DIR="${XDG_DATA_HOME}/zsh"

# Source all env files from env.d directory
for zshenv in $ZSH_CONFIG_DIR/env.d/**/*.zsh; do
  source "$zshenv"
done
