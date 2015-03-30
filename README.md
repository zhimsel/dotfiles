# zhimsel/dotfiles

These are my config files. I use them live, in 'production'. You're welcome to use them directly, or fork them. Keep in mind they may change suddenly, frequently, and for seemingly no reason. They may (and do) break. Use them at your own risk (minimal as that is).

If you think you have an improvement, feel free to submit an issue, or pull request.

### Usage
To install these dotfiles (in say, a clean home directory), simply clone this repo to a folder of your choice (a logical choice would be ~/dotfiles or ~/.dotfiles), and run the `install.sh` script. 

Please keep in mind that this script *should* not change any files, but it *might*, so please read the script and understand what it does before you run it. It symlinks all the dotfiles here into your home directory, and any existing files are renamed with the '.local' extension. If a file with the '.local' extension already exists, it does nothing and notifies you that manual intervention is needed. 

If you would like to only link *some* of the files, simply edit the `files` variable array before you run it.

### OSX
For usage on an OSX machine, there are two shell scripts to help with setting up some defaults.

#### osx.sh
Sets some sensible system defaults that aren't accessible through the system menus. Read through the changes being made (everything is commented with what it does) before running and remove anything you don't want.

#### brew.sh
Installs some useful packages and replaces some outdated built-in OSX packaes with up-to-date versions. Requires [homebrew](http://brew.sh/) before use.

For `coreutils`, to 'replace' the stock binaries with the gnu binaries (and not use the 'g' prefix, like `gls`), simply add the following to your ~/.zshrc.local:

```
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
```

### Errors

If you get an error about zsh/git-prompt.zsh/dist missing, this means that the zshrc has detected you have haskell installed on your machine, but the haskell binaries for zsh-git-prompt have not been compiled. To fix this, simply `cd` into [zsh/git-prompt.zsh](zsh/git-prompt.zsh) and run `cabal build`. 

### License
These files are licensed under the [MIT license](LICENSE) and are freely available for any use.
