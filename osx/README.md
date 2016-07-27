# OSX

For usage on an OSX machine, there are two shell scripts to help with setting up some sane defaults:

## osx.sh

Sets some sensible system defaults that aren't accessible through the system menus. Read through the changes being made (everything is commented with what it does) before running and remove anything you don't want.

## brew.sh

Installs some useful packages and replaces some outdated built-in OSX packaes with up-to-date versions. Requires [homebrew](http://brew.sh/) before use. Read through the packages installed and remove any you don't want.

For `coreutils`: to replace the OSX coreutil binaries with the gnu binaries (and not use the 'g' prefix, like `gls`), simply add the following to your `~/.zshrc.local` (or local bashrc, if you are still in the dark ages):

```
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
```

