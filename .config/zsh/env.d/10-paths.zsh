# Set special path variable types and remove duplicate entries
typeset -gxU path
typeset -gxU manpath
typeset -gxU fpath

# Set XDG variables, if not already set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Manually override some program's paths to use XDG paths (that don't support them natively)
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/config"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"

# Add ~/bin to beginning of stack to allow overriding any system-installed executables
path=("$HOME/bin" $path)
