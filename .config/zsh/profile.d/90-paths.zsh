# Add ~/bin to beginning of stack (mosty last) to allow
# overriding any system-installed executables
path=("$HOME/bin" $path)

# ASDF shims need to go at the very beginning of the $PATH
path=("${ASDF_DATA_DIR}/shims" $path)
