# Source all rc files from rc.d directory
for zshrc in $ZSH_CONFIG_DIR/rc.d/**/*.zsh; do
  source "$zshrc"
done
