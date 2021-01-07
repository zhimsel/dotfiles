# zhimsel/dotfiles

These are my config files. I use them live, in 'production'. You're welcome to use them directly, or fork them. Keep in mind they may change suddenly, frequently, and for seemingly no reason. They may (and do) break. Use them at your own risk (minimal as that is).

If you think you have an improvement, feel free to submit an issue or pull request.

## Install

This repo is intended to be based directly in your home directory, with a `.git` dir named as something else (as to not cause all subdirectories to think they're a git repo).
To do an initial clone of this repo, follow the steps below:

```sh
cd $HOME

# set up git repo and install tracked files
export GIT_DIR=$HOME/.git_dotfiles GIT_WORK_TREE=$HOME
git init
git remote add origin git@github.com:zhimsel/dotfiles.git
git fetch
git checkout -t origin/master  # will report any conflict files; fix these and re-run
git submodule update --init --recursive  # fetch submodules

# install zsh plugins
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zinit"
git clone https://github.com/zdharma/zinit.git "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zinit/bin"
zsh -ic 'zinit update --all'

# install vim plugins
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
```

You can then use the included `dot` alias (in `$HOME/.zshrc`) to perform git commands against the dotfiles repo.
To track new dotfiles, you need to use `git add -f`, since everything is ignored by default.
Use the `nodot` alias to stop working on the dotfiles repo.

To update all the required zsh and vim plugins, use the included `dotu` command (in `.zshrc`).

### OS-specific setup

#### MacOS/OSX

Install [Homebrew](https://docs.brew.sh/Installation) and run:

```
brew bundle --global install
```

#### Arch Linux

Install your choice of AUR-helper (I recommend [`yay`](https://aur.archlinux.org/packages/yay/)) and do:

```
yay -Syu --needed - < .arch-packages.list
```

## Keyboard configuration

### ZSA Moonlander

I primarily use a ergonomic split keyboard from ZSA called the Moonlander.
My current configuration and key maps can be found
[here](https://configure.ergodox-ez.com/moonlander/layouts/XE4RP/latest/0).

I don't currently care to commit the config source here since my layout
changes frequently and I'm not currently making any modifications to the
firmware that Oryx can't do. Maybe I'll change that in the future.

## License

These files are licensed under the [MIT license](/LICENSE) and are freely available for any use.
