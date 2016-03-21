" Written by Zach Himsel, 2013-2016
" https://github.com/zhimsel/dotfiles


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load plugins (must come first)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source ~/.vim/vim-plug/plug.vim
call plug#begin('~/.vim/plugins')

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline-themes'

" Syntax plugins
Plug 'scrooloose/syntastic'
Plug 'svermeulen/vim-extended-ft'
Plug 'avakhov/vim-yaml', { 'for': ['yaml', 'yml'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
Plug 'python.vim', { 'for': 'python' }
Plug 'SQLComplete.vim', { 'for': 'sql' }
Plug 'rstacruz/sparkup', { 'for': 'html' }
Plug 'fountain.vim', { 'for': 'fountain' }
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'jtratner/vim-flavored-markdown', { 'for': 'markdown' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'zhimsel/vim_cf3', { 'for': 'cf3' }

" Interface plugins
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Lokaltog/vim-easymotion'
Plug '~/.fzf'  " fzf is not just for vim, so it's managed externally
Plug 'junegunn/fzf.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'tpope/vim-obsession'
Plug 'wellle/targets.vim'
Plug 'kopischke/vim-stay'
Plug 'Konfekt/FastFold'

" Git plugins
Plug 'mathstuf/vim-fugitive', { 'branch': 'git-workdir-support' }
Plug 'taq/vim-git-branch-info'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'  " required for gist-vim
Plug 'Xuyuanp/nerdtree-git-plugin'

" Automation plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'renamer.vim', { 'on': 'Renamer' }
Plug 'justinmk/vim-gtfo'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
if has ('nvim')
  Plug 'Shougo/deoplete.nvim'
else
  Plug 'Shougo/neocomplete.vim'
endif

" Add locally-defined plugins
if filereadable(glob("~/.vim-plug.local"))
  source ~/.vim-plug.local
endif

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
if !has('nvim')
  set viminfo='1000,f1,:100,@100,/20
endif
set history=1000
set iskeyword+=_,$,@,%,#,-
set nofoldenable


" Enable syntax highlighting
syntax enable

" Set color scheme
set background=dark
silent! colorscheme solarized

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use 'Silent' for supressing 'Hit Enter to continue' prompt
command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'


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
noremap ' "
noremap '' "+
noremap ''' :registers<cr>


" Disable highlight when <leader><Esc>, <Esc><Esc, or F1 is pressed
map <silent> <F1> :noh<cr>
nmap <silent> <Esc><Esc> :noh<cr>

" Paste pdb block in (for python debugger)
imap <C-p> import pdb; pdb.set_trace()

" Remap 'K'; it's fucking annoying
nnoremap K <Nop>
vnoremap K <Nop>

" Move lines up/down
nnoremap <Down> :m+<CR>==
nnoremap <Up> :m-2<CR>==
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap <Up> :m '<-2<CR>gv=gv

" Move selected text left/right
vnoremap <Right> xp`[v`]
vnoremap <Left> xhhp`[v`]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDtree settings
map <C-t> :NERDTreeToggle<CR>
" Prevent vim from considering NERDtree a window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeHighlightCursorline = 1
let NERDTreeMouseMode = 1
let NERDTreeShowLineNumbers = 1


" vim-json settings
set conceallevel=0 " Disable character concealing
let g:vim_json_syntax_conceal = 0 " Force no concealing for json files
highlight Error term=reverse cterm=bold ctermfg=7 ctermbg=1 guifg=White guibg=Red


" vim-airline settings
set timeoutlen=500 " Set timeout for statusline redraw on escape
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_nr = 1 " show tab numbers
let g:airline#extensions#tabline#tab_nr_type = 1 " show only tab number
let g:airline_powerline_fonts = 1

" vim-gitgutter settings
let g:gitgutter_sign_column_always = 1
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
highlight clear LineNr
highlight clear SignColumn
set numberwidth=1 " reduce extra spaces between signs and line numbers


" git keybindings (both vim-fugitive and vim-gitgutter)
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Silent Git commit -v<cr>
nmap <leader>gf :Gfetch<cr>
nmap <leader>gm :Gmerge<cr>
nmap <leader>gl :Silent Git l<cr>
nmap <leader>ga :Silent Git add %<cr>:w<cr>
nmap <leader>gp :Silent Git add -p %<cr>
nmap <leader>gd :Silent Git diff --cached<cr>
nmap <leader>gD :Silent Git diff<cr>
nmap <leader>gg :Silent Git 
nmap <leader>gv :Gitv<cr>
nmap <leader>ha <Plug>GitGutterStageHunk
nmap <leader>hr <Plug>GitGutterRevertHunk
nmap <leader>hn <Plug>GitGutterNextHunk
nmap <leader>hp <Plug>GitGutterPrevHunk


" vim-easymotion settings
hi link EasyMotionTarget DiffChange
hi link EasyMotionTarget2First DiffChange
hi link EasyMotionTarget2Second DiffAdd
hi link EasyMotionShade Comment
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>j <Plug>(easymotion-j)
map <leader><leader>k <Plug>(easymotion-k)
map <leader><leader>h <Plug>(easymotion-linebackward)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)


" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_wq = 0
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_chef_checkers = ['foodcritic']
nmap <leader>[ :lprevious<cr>
nmap <leader>] :lnext<cr>
nmap <leader>\ :SyntasticCheck<cr>:Errors<cr>


" deoplete/neocomplete setting
let g:deoplete#enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
set completeopt+=noinsert,noselect
imap <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
imap <expr><C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
function! s:is_whitespace() "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~? '\s'
endfunction "}}}
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return deoplete#mappings#smart_close_popup() . "\<CR>"
endfunction


" fzf settings
nnoremap <c-p> :Files<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap <c-f> :BLines<cr>
nnoremap <c-g> :GitFiles<cr>
nnoremap M :Marks<cr>
let g:fzf_layout = { 'window': 'new', 'down': '12' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


" CFEngine plugin settings
let g:EnableCFE3KeywordAbbreviations=1

" Tabularize settings
command! -range CFalign <line1>,<line2>Tabularize /=>/r1l1l1

" vim-gist settings
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_clip_command = 'pbcopy'

" vim-stay settings
set viewoptions=cursor,folds,slash,unix

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
set mouse=a " Enable mouse interaction
if !has('nvim')
  set ttymouse=sgr " Set mouse mode to xterm2 (works best for most modern terminals)
endif


" change cursor shape based on mode (for iTerm2)
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Define text expansions
iab #ube #!/usr/bin/env

" executes current file (if executable)
nnoremap <leader>x :!%:p<cr>

" stop <Esc> from moving the cursor
inoremap <Esc> <Esc>`^


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

if !has('nvim')
  set viminfo+=n~/.vim/viminfo
endif

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

" Configure per-filetype settings
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.py,*.pyw set shiftwidth=4 tabstop=4
au BufRead,BufNewFile *.java set shiftwidth=4 tabstop=4
au BufRead,BufNewFile *.fountain   set filetype=fountain
au BufRead,BufNewFile {Berksfile,Vagrantfile,Gemfile} set filetype=ruby
au BufRead,BufNewFile *.pp   set filetype=ruby
au BufRead,BufNewFile *.yaml,*.yml   set filetype=yaml
au BufRead,BufNewFile *.cf set filetype=cf3 commentstring=#\ %s smartindent
au BufRead,BufNewFile COMMIT_EDITMSG setlocal commentstring=\%%s
au BufRead,BufNewFile *.sql SQLSetType mysql

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

" use system clipboard for main register (unless specified with '/")
" set clipboard^=unnamed


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
"map j gj
"map k gk

" remap pane-movement keys
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" better split placements
set splitbelow
set splitright

" tab shortcuts
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t :tabnext<cr>
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt
map <leader><Left> :tabprevious<cr>
map <leader><Right> :tabnext<cr>


" Open splits
nmap <Leader>s :sp<cr>
nmap <Leader>v :vsp<cr>


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
if !has('nvim')
  set viminfo^=%
endif


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

" Eatchar and Getchar functions for CFEngine
fun! Getchar()
  let c = getchar()
  if c != 0
    let c = nr2char(c)
  endif
  return c
endfun

fun! Eatchar(pat)
   let c = Getchar()
   return (c =~ a:pat) ? '' : c
endfun


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load local config (should always be last)
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
