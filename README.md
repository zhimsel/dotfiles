# zhimsel/dotfiles

### Dotfiles
These are my config files. I use them live, in 'production'. You're welcome to use them directly, or fork them. Keep in mind they may change suddenly, frequently, and for seemingly no reason. They break. Use them at your own risk (minimal as that is).

If you think you have an improvement, feel free to submit an issue, or pull request.

### Usage
To install these dotfiles (in say, a clean home directory), simply clone this repo to a folder of your choice (a logical choice would be ~/dotfiles or ~/.dotfiles), and run the `install.sh` script. 

Please keep in mind that this *should* not change any files, but it *might*, so please read the script and understand what it does before you run it. It symlinks all the dotfiles here into your home directory, and any existing files are renamed with the '.local' extension. If a file with the '.local' extension already exists, it does nothing and notifies you that manual intervention is needed. 

If you would like to only link *some* of the files, simply edit the `files` variable array before you run it.

### License
These files are licensed under the [MIT license](LICENSE) and are freely available for any use.