" Some basic settings
set nocompatible

set history=50		" keep 50 lines of command line history
set incsearch		" do incremental searching
"nnoremap <esc> :noh<return><esc>
set backspace=indent,eol,start
set ruler               " show line and column number
syntax on   			" syntax highlighting
set showcmd 			" show (partial) command in status line
set background=light




" Set backups/swap/undo/viminfo files to ~/.vim

if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup//
set backupdir^=./.vim-backup/
set backup

if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap/
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif





" configure expanding of tabs for various file types
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
"set expandtab           " enter spaces when tab is pressed
"set tabstop=4           " use 4 spaces to represent tab
"set softtabstop=4
"set shiftwidth=4        " number of spaces to use for auto indent
let python_highlighting_all=1




" Set auto-indenting at 80 characters
" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")




if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
