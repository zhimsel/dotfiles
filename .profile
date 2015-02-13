prefered__shell=
if [ -x /bin/zsh ]; then
  prefered_shell=/bin/zsh
fi
if [ -n "$prefered_shell" ]; then
  case $- in
    *i*) SHELL=$prefered_shell; export SHELL; exec "$prefered_shell";;
  esac
fi

source .profile.local
