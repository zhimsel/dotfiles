#!/usr/bin/env bash

# Make sure homebrew is installed
if [[ ! -e $(which brew) ]]; then
  echo "Homebrew is not installed! Follow install instructions here: http://brew.sh/"
  exit 1
fi

# Get latest packages
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Assemble a list of packages to install
packages=(\
  # Install GNU core utilities (those that come with OS X are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  coreutils

  # Install some other useful utilities like `sponge`.
  moreutils
  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  findutils
  # Install GNU `sed`, don't forge to alias 'sed' to 'gsed'
  gnu-sed

  # Install shell and utils
  zsh
  zshdb
  bash
  bash-completion

  # Install `wget` with IRI support.
  wget --with-iri

  # Install more recent versions of some OS X tools.
  vim --override-system-vi
  homebrew/dupes/grep
  homebrew/dupes/openssh
  homebrew/dupes/screen
  ack
  git
  p7zip
  pv
  rename
  tree
  curl
  gnupg

  # Misc packages
  android-platform-tools
  awscli
  cmake
  exiftool
  fzf  # don't forget to run the installer script after install (see "caveats")
  htop-osx
  hub
  iftop
  irssi
  jq
  lame
  links
  macvim
  markdown
  ncdu
  ncurses
  nmap
  pip-completion
  rake-completion
  ruby-completion
  s3cmd
  s3cmd
  shellcheck
  sqlite
  tig
  tmux
  vagrant-completion
  watch
  wget
)

cask_packages=(\
  1password
  adium
  avidemux
  clipmenu
  deluge
  evernote
  flux
  google-chrome
  iterm2
  keka
  libreoffice
  macdown
  messenger
  mumble
  slack
  stellarium
  vlc
)

# Install them
brew install "${packages[@]}"
brew cask install "${cask_packages[@]}"

# Remove outdated versions from the cellar.
brew cleanup
