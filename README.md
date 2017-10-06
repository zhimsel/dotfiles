# zhimsel/dotfiles

[![Build Status](https://travis-ci.org/zhimsel/dotfiles.svg?branch=master)](https://travis-ci.org/zhimsel/dotfiles)

These are my config files. I use them live, in 'production'. You're welcome to use them directly, or fork them. Keep in mind they may change suddenly, frequently, and for seemingly no reason. They may (and do) break. Use them at your own risk (minimal as that is).

If you think you have an improvement, feel free to submit an issue or pull request.

### Usage

To install these dotfiles (in say, a clean home directory), simply clone this repo to a folder of your choice (a logical choice would be ~/dotfiles or ~/.dotfiles), and run the `install.py` script. The install script will then create symlinks pointing to config files in that repo and clone the git submodule dependencies in `lib`.

Each file that needs to be symlinked has a corresponding `.link` file. It's a simple text file that contains the paths where the related file should be linked. For instance, `vimrc` has a `vimrc.link` file that contains `~/.vimrc`. A symlink will be created at `~/.vimrc` that points to the `vimrc` file in this repo. The `.link` files support multiple link targets; just place each on on its own line.

Please keep in mind that this script *should* not change any files, but it *might*, so please read the script and understand what it does before you run it. Any existing files are backed up first.

If you would like to only link *some* of the files, simply remove the corresponding `.link` file.

### License

These files are licensed under the [MIT license](/LICENSE) and are freely available for any use.
