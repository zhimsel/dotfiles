" vim configuration
" Written by Zach Himsel, 2013-2015
" https://github.com/zhimsel/dotfiles


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load plugins (must come first)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set up vundle
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()


" Load plugins
Plugin 'fountain.vim'
Plugin 'tpope/vim-surround'
Plugin 'avakhov/vim-yaml'
Plugin 'elzr/vim-json'
Plugin 'rodjek/vim-puppet'
Plugin 'python.vim'
Plugin 'sql.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-repeat'
Plugin 'rstacruz/sparkup'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'taq/vim-git-branch-info'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'svermeulen/vim-extended-ft'
Plugin '0x0dea/vim-molasses'
Plugin 'Valloric/YouCompleteMe' " make sure this is always last (takes a long time to load)



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set history=1000
set viminfo='1000,f1,:100,@100,/20
set isk+=_,$,@,%,#,-	" none word dividers


" Enable syntax highlighting
syntax enable

" Set color scheme
set background=dark
colorscheme solarized

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set leader key
let mapleader = "\<space>"
let g:mapleader = "\<space>"

" Fast saving/opening/quitting
nmap <leader>e :e<cr>
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>wq :wq<cr>
nmap <leader>qa :qa<cr>
nmap <leader>wqa :wqa<cr>

" Quickly toggle line numbers
nmap <leader>n :set number!<cr>
nmap <leader>N :set relativenumber!<cr>

" :WW sudo saves the file with root permissions
command WW w !sudo tee % > /dev/null

" Toggle paste mode on and off
nmap <leader>p :set paste!<cr>

command W write " stop that pesky shift key
command Q quit " stop that pesky shift key
command Wq wq " stop that pesky shift key
command WQ wq " stop that pesky shift key

" Remaps the macro record key 'q' to 'Q' instead
nnoremap Q q
nnoremap q <Nop>

" Remaps ' key (duplicated in ` anyway)
nnoremap ' "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDtree settings
map <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" vim-json settings
set conceallevel=0 " Disable character concealing
let g:vim_json_syntax_conceal = 0 " Force no concealing for json files


" vim-airline settings
set timeoutlen=400 " Set timeout for statusline redraw on escape


" vim-gitgutter settings
let g:gitgutter_sign_column_always = 1
highlight clear LineNr
highlight clear SignColumn
set numberwidth=1 " reduce extra spaces between signs and line numbers


" git keybindings (both vim-fugitive and vim-gitgutter)
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gf :Gfetch<cr>
nmap <leader>gm :Gmerge<cr>
nmap <leader>gl :Git log<cr>
nmap <leader>ga :Git add %<cr>
nmap <leader>gp :Git add -p %<cr>
nmap <leader>gd :Git diff<cr>
nmap <leader>gg :Git
nmap <leader>ha <Plug>GitGutterStageHunk

" vim-easymotion settings
hi link EasyMotionTarget Search
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
hi link EasyMotionShade Comment



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set some built-in settings
set number " show line numbers and set color
set showcmd " show (partial) command in status line
set report=0 " tell us about changes
set nostartofline " don't jump to start of line when scrolling
set scrolloff=7 " Set 7 lines to the cursor - when moving vertically using j/k
set shortmess+=I " Disable welcome message
set wildmenu " Enable wildcard matching in ex commands
set ruler "Always show curent position
set cmdheight=1 " Height of the command bar1
set hid " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l " Wrap lines on movement for 'h/l' keys
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers
set lazyredraw " Don't redraw while executing macros (good performance config)
set magic " For regular expressions turn magic on
set showmatch " Show matching brackets when text indicator is over them
set matchtime=2 " How many tenths of a second to blink when matching brackets


" change cursor shape based on mode (for iTerm2)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Define text expansions
iab #ube #!/usr/bin/env



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup//
set backupdir^=./.vim-backup/
set nobackup

set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

set path=**


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set sensible defaults for tab width
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

" Auto-indenting/breaking
set autoindent
set wrap
set linebreak
set nolist

" Set auto-indenting at 79 characters
if has("autocmd")
  filetype plugin indent on
  filetype indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
endif

" Configure expanding of tabs for file types
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4 tabstop=4
au BufRead,BufNewFile *.java set shiftwidth=4 tabstop=4
au BufRead,BufNewFile *.fountain   set filetype=fountain
au BufRead,BufNewFile {Berksfile,Vagrantfile,Gemfile} set filetype=ruby
let python_version_2 = 1

" Java settings
let java_mark_braces_in_parens_as_errors=1
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_java_lang_ids=1
let java_highlight_functions="style"
let java_minlines=150

" autocomplete brackets
inoremap {{      {}<Left>
inoremap {{<CR>  {<CR>}<Esc>O

" highlight trailing whitespace with red
set list listchars=trail:.,tab:>.
highlight SpecialKey ctermfg=Red ctermbg=none



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
"map j gj
"map k gk

" Disable highlight when <leader><Esc> (or F1) is pressed
map <silent> <F1> :noh<cr>
map <silent> <leader><Esc> :noh<cr>

" Tmux splits compatitibility
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" better split placements
set splitbelow
set splitright

" buffer shortcuts
map <leader>bc :Bclose<cr>
map <leader>bda :1,1000 bd!<cr>
map <leader>bn :bn<cr>
map <leader>bl :ls<cr>
map <leader>1 :1b<CR>
map <leader>2 :2b<CR>
map <leader>3 :3b<CR>
map <leader>4 :4b<CR>
map <leader>5 :5b<CR>
map <leader>6 :6b<CR>
map <leader>7 :7b<CR>
map <leader>8 :8b<CR>
map <leader>9 :9b<CR>
map <leader>10 :10b<CR>
map <leader>11 :11b<CR>
map <leader>12 :12b<CR>
map <leader>13 :13b<CR>
map <leader>14 :14b<CR>
map <leader>15 :15b<CR>
map <leader>16 :16b<CR>
map <leader>17 :17b<CR>
map <leader>18 :18b<CR>
map <leader>19 :19b<CR>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2	" always display the status line
set showtabline=1

hi VertSplit ctermfg=black ctermbg=yellow

hi User1 ctermfg=yellow cterm=underline
hi User2 ctermfg=yellow cterm=bold,underline
hi User3 ctermfg=red cterm=bold,underline

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE'
    en
        return ''
endfunction

" Git status line settings
let g:git_branch_status_head_current=1
let g:git_branch_status_text='git'
let g:git_branch_status_nogit=''
let g:git_branch_status_ignore_remotes=1
let g:git_branch_status_check_write=1

set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%2*\ %<%F%*            "full path
set statusline +=%3*%m%*                "modified flag
set statusline +=%1*\ \ \ %{&ff}%*        "file format
set statusline +=%1*%y%*                "file type
set statusline +=%1*\ \ \ %{GitBranchInfoString()}   "git branch
set statusline +=%1*\ \ \ %{HasPaste()}   "paste mode
set statusline +=%1*%=                 "whitespace
set statusline +=%2*%5l%*             "current line
set statusline +=%1*/%L%*               "total lines
set statusline +=%2*%4v\ \ %*           "virtual column number
set statusline +=%1*0x%04B\ %*          "character under cursor



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! CmdLine(str)
"    exe "menu Foo.Bar :" . a:str
"    emenu Foo.Bar
"    unmenu Foo
"endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load local config (should always be last)
if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif
