#!/usr/bin/env bash

# Symlinking logic borrowed from https://github.com/captbaritone/dotfiles/blob/master/install.sh
# Thanks, Cap'n!

# Check if old version of dotfiles is currently in use
if [[ -e "$HOME/.git" ]]; then
  echo "Existing ~/.git repo detected! Please remove the old repo before proceeding."
  exit 1
fi

# Get full path of current dir
repo_path="$(cd "$(dirname "$0")" ; pwd -P)"

# List of dotfiles that we'll be symlinking
dotfiles=(\
  bashrc \
  gitconfig \
  gitignore_global \
  gnupg \
  lftprc \
  profile \
  tmux.conf \
  vim \
  vimrc \
  zsh \
  zshrc \
  config/flake8 \
)

# Prompt user for permission to continue
overwrite_check_prompt () {
read -p "This MIGHT overwrite existing files in your home directory. Are you sure? (y/N) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  :
else
  echo "Exiting with no changes."
  exit 2
fi
}

# Ask user if they want scripts
install_scripts_prompt () {
  read -p "Would you like to install zhimsel/scripts, too? (y/N) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    want_scripts=1
  fi
}

# Pull down scripts repo and make ~/bin
install_scripts () {
  if [[ $want_scripts == 1 ]]; then
    echo "Cloning scripts repo into ~/scripts"
    git clone https://github.com/zhimsel/scripts.git ~/scripts
    mkdir -p ~/bin
    echo "Manually symlink any scripts you want to use into ~/bin"
  fi
}

# Generate the destination path of a dotfile
dot_path () {
  echo "$HOME/.$1"
}

# Generate the destination path of a dotfile
backup_path () {
  echo "$HOME/.$1~"
}

# Links the passed filename to its new location
link () {
  local filename=$1
  local path
  path="$(dot_path "$filename")"

  # First, check if ~/.config exists
  if [[ ! -e ~/.config ]]; then
    mkdir ~/.config
  fi

  # Check if source dotfile exists
  if [[ ! -e "$filename" ]]; then
    echo "Error: $filename doesn't exist."
    return
  fi

  # Check if target exists, back up if so
  if [[ -e $path ]] && [[ ! -L $path ]]; then
    local backuppath
    backuppath=$(backup_path "$filename")
    if [[ -e $backuppath ]]; then
      echo "Both $path and $backuppath exist. Cannot do anything automatically. Please reconcile manually."
    else
      mv "$path" "$backuppath"
      echo "$path exists. Backing up to $backuppath before symlinking."
    fi
  fi

  # Actually link the source dotfile
  if [[ -L $path ]]; then
    echo "Link exists! $path"
  elif [[ ! -e $path ]]; then
    echo "Linking: $filename to $path"
    ln -s "$repo_path"/"$filename" "$path"
  fi
}

# Loops through and link all files without links
install_links () {
  echo "Linking dotfiles into place:"
  cd "$repo_path"
  for file in "${dotfiles[@]}"
  do
    link "$file"
  done
}

# Prompt if user wants to install 'YouCompleteMe'
youcompleteme_prompt () {
  read -p "Would you like to install and build YouCompleteMe for vim? (y/N) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    want_youcompleteme=1
  fi
}

# Install vim plugins
install_vim_plugins () {
  if [[ "$want_youcompleteme" = 1 ]]; then
    echo "Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }" >> ~/.vim-plug.local
  fi
  vim +PlugUpdate +qall
}

# Initialize git submodules
init_submodules () {
  echo "Initializing git submodules..."
  cd "$repo_path"
  git submodule update --init --recursive
}

# Compile zsh-git-prompt
compile_zsh_git_prompt () {
  if [[ -e "$(which cabal 2> /dev/null)" ]]; then
    echo" Compiling Haskell binaries for zsh-git-prompt:"
    cd "$repo_path/zsh/git-prompt.zsh"
    cabal configure
    cabal build
  fi
}

# Disable host-key checking for github
disable_github_host_key_checking () {
  echo -e "Host github.com\n\ \ StrictHostKeyChecking no\n" >> ~/.ssh/config
}


# Actually do it!
overwrite_check_prompt
install_scripts_prompt
youcompleteme_prompt
echo ""
disable_github_host_key_checking
init_submodules
compile_zsh_git_prompt
install_links
install_scripts
install_vim_plugins
