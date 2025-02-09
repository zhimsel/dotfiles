# Manually override some program's paths to use XDG paths (that don't support them natively)
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/config"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
path=("${ASDF_DATA_DIR}/shims" $path)
