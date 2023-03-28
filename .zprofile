# Source all profile files from profile.d directory
for zprofile in $ZSH_CONFIG_DIR/profile.d/**/*.zsh; do
  source "$zprofile"
done
