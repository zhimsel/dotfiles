#!/usr/bin/env bash

cd "$(dirname $0)"

# install function
function install_dotfiles() {
  source=$(dirname $0)
  echo "Copying from git repo path: $source"
  cd $source
  cp -aP .* ~/
  cd ~
  echo "Installing git submodules"
  git submodule init
  git submodule update
  echo "Installing vim plugins"
  vim +PluginUpdate +qall
  echo ""
}

function install_scripts() {
  echo "Cloning scripts repo into ~/scripts"
  git clone https://github.com/zhimsel/scripts.git ~/scripts
  mkdir -p ~/bin
  echo "Symlink any scripts you want to use into ~/bin"
}

# install scripts, too?
read -p "Would you like to install your scripts, too? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  scripts=1
fi

# prompt user for permission to continue
read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  install_dotfiles
  if [[ $scripts == 1 ]]; then
    install_scripts
  fi
fi
echo ""

# unset functions
unset install_dotfiles;
unset install_scripts;
