" Load base plugin set
" Additional plugins can be added in any file before 99-end.vim
let g:plug_window = 'enew'
call plug#begin(stdpath('data') . '/vim-plug')

" Visual plugins {{{
Plug 'airblade/vim-gitgutter'  " git diff symbols in sign column
Plug 'chrisbra/Colorizer'  " highlight color codes with their color
Plug 'chriskempson/base16-vim'  " better themes
Plug 'ntpeters/vim-better-whitespace'  " highlight unwanted whitespaces
Plug 'vim-airline/vim-airline'  " better statusbar
Plug 'vim-airline/vim-airline-themes'  " themes for Airline
Plug 'Xuyuanp/nerdtree-git-plugin'  " show git status symbols in NERDTree
Plug 'Yggdroot/indentLine'  " visual marker for indent level
" }}}

" Extending/improving the base interface {{{
Plug 'christoomey/vim-tmux-navigator'  " switch between tmux/vim panes seamlessly
Plug 'git@github.com:zhimsel/vim-stay.git', { 'dir': '~/dev/vim-stay', 'frozen': 'true' }  " save and restore view when closing file buffers
Plug 'jlanzarotta/bufexplorer'  " interactive buffer management
Plug 'junegunn/fzf.vim'  " fuzzy-finding all sorts of things (files, buffers, lines, etc)
Plug 'junegunn/vim-easy-align'  " easily align text into columns
Plug 'junegunn/vim-peekaboo'  " preview registers before using them
Plug 'kassio/neoterm'  " open terminal easily
Plug 'Lokaltog/vim-easymotion'  " improved motions with skipping objects
Plug 'mattn/gist-vim'  " save current buffer/selection as a Github gist
Plug 'mbbill/undotree'  " visual selection of entire undo tree for a file
Plug 'michaeljsmith/vim-indent-object'  " use indent levels as text objects
Plug 'preservim/nerdtree'  " file/directory explorer
Plug 'tpope/vim-abolish'  " improved search/replace with case-specific behavior
Plug 'tpope/vim-dispatch'  " asynchronous tasks
Plug 'tpope/vim-fugitive'  " lots of git commands/shortcuts
Plug 'tpope/vim-rhubarb'  " interface for Github
Plug 'unblevable/quick-scope'  " highlight t/T/f/F targets
Plug 'wellle/targets.vim'  " additional text objects
Plug 'yaronkh/vim-winmanip'  " move windows around more easily
Plug 'wesQ3/vim-windowswap'  " swap two panes easily
" }}}

" Custom text objects {{{
Plug 'kana/vim-textobj-user'  " required by any vim-textobj-* plugins

Plug 'glts/vim-textobj-comment'  " use comments as text objects
Plug 'kana/vim-textobj-fold'  " use folds as text objects
Plug 'pianohacker/vim-textobj-indented-paragraph'  " use paragraph-at-indent as textobjects
Plug 'rhysd/vim-textobj-ruby'  " use ruby blocks as text objects
" }}}

" Automating repetitive tasks  {{{
Plug 'PeterRincker/vim-argumentative' " manipulate function arguments
Plug 'qpkorr/vim-renamer', { 'on': 'Renamer' }  " batch-rename files in vim
Plug 'tpope/vim-commentary'  " comment/uncomment lines automatically
Plug 'tpope/vim-endwise'  " automatic if/for/etc block closing
Plug 'tpope/vim-eunuch'  " useful shell commands
Plug 'tpope/vim-repeat'  " improved repeats
Plug 'tpope/vim-surround'  " add/remove/modify surrounding brackets/quotes/etc
Plug 'tyru/open-browser.vim'  " open URLs in browser
" }}}

" Autocompletion/linting {{{
Plug 'benekastah/neomake'  " automated linting
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  " word completion
" }}}

" Filetype-specific plugins {{{
Plug 'elzr/vim-json'  " JSON syntax/etc
Plug 'hashivim/vim-terraform'  " Terraform syntax/etc
Plug 'hotwatermorning/auto-git-diff'  " show commit diff for interactive rebases
Plug 'masukomi/vim-markdown-folding'  " Better folding for Markdown
Plug 'pedrohdz/vim-yaml-folds'  " Better folding for YAML
Plug 'tmhedberg/SimpylFold'  " Better folding for Python
Plug 'tpope/vim-git'  " Syntax/etc for git files (commit messages, etc)
Plug 'zhimsel/vim-markdown-preview', { 'for': ['markdown'], 'branch': 'default_browser_assumption' }  " Open a Github-flavored rendered preview of a Markdown file in the browser
" }}}

" Dependencies {{{
Plug 'junegunn/fzf'  " required by: junegunn/fzf.vim
Plug 'mattn/webapi-vim'  " required by: mattn/gist-vim
" }}}
