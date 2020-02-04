# zhimsel/dotfiles

These are my config files. I use them live, in 'production'. You're welcome to use them directly, or fork them. Keep in mind they may change suddenly, frequently, and for seemingly no reason. They may (and do) break. Use them at your own risk (minimal as that is).

If you think you have an improvement, feel free to submit an issue or pull request.

### Usage

This repo is intended to be based directly in your home directory, with a `.git` dir named as something else (as to not cause all subdirectories to think they're a git repo).
To do an initial clone of this repo, follow the steps below:

```sh
cd $HOME
export GIT_DIR=$HOME/.dotfiles_git GIT_WORK_TREE=$HOME
git init
git config --local status.showUntrackedFiles no
git config --local tig.status-show-untracked-files false
git remote add origin git@github.com:zhimsel/dotfiles.git
git fetch
git checkout -t origin/master  # will report any conflict files; fix these and re-run
git submodule update --init --recursive
```

You can then use the included `dot` alias (in `$HOME/.zshrc`) to perform git commands against the dotfiles repo (from anywhere).

### License

These files are licensed under the [MIT license](/LICENSE) and are freely available for any use.
