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

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install shell and utils
brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting
brew install zsh-history-substring-search
brew install bash-completion

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install ack
brew install git
brew install lynx
brew install p7zip
brew install pv
brew install rename
brew install tree

# Misc installs
brew install awscli
brew install exiftool
brew install htop-osx
brew install jq
brew install lastpass-cli
brew install mackup
brew install macvim
brew install markdown
brew install ncdu
brew install ncurses
brew install nmap
brew install s3cmd
brew install screen
brew install tig
brew install tmux
brew install watch
brew install wget

# Remove outdated versions from the cellar.
brew cleanup
