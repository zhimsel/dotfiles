" vim:foldmethod=marker

" This file is written with vim foldmarkers to enable easier viewing
" It's designed to be viewed/edited from within vim. Each section has
" fold markers at the beginning and end, so you can easily close each
" section to find what you're looking for

" Written by Zach Himsel, 2013-present
" https://github.com/zhimsel/dotfiles


" Plugins {{{
" Loading plugins must come first

let g:plug_window = 'enew'
runtime vim-plug/plug.vim  " managed externally (via dotfiles submodules)
call plug#begin(stdpath('data') . '/vim-plug')

" Colors {{{
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'
" }}}

" Syntax plugins {{{
Plug 'pedrohdz/vim-yaml-folds', { 'for': ['yaml', 'yml'] }
Plug 'benekastah/neomake'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'jtratner/vim-flavored-markdown', { 'for': 'ghmarkdown' }
Plug 'nelstrom/vim-markdown-folding', { 'for': ['markdown', 'ghmarkdown'] }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'svermeulen/vim-extended-ft'
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
Plug 'tpope/vim-git'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'zhimsel/vim-markdown-preview', { 'for': ['markdown', 'ghmarkdown'], 'branch': 'default_browser_assumption' }
" }}}

" Interface plugins {{{
Plug 'Lokaltog/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'bling/vim-airline'
Plug 'git@github.com:zhimsel/vim-stay.git', { 'dir': '~/dev/vim-stay', 'frozen': 'true' }
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'  " required by fzf.vim
Plug 'mbbill/undotree'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish', { 'on': 'Subvert' }
Plug 'tpope/vim-obsession'
Plug 'vim-scripts/vis'
Plug 'wellle/targets.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'kassio/neoterm'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-user'  " required by vim-textobj-fold
" }}}

" Git plugins {{{
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'iberianpig/tig-explorer.vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'  " required for gist-vim
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser-github.vim'
Plug 'tyru/open-browser.vim'
Plug 'hotwatermorning/auto-git-diff'
" }}}}

" Automation plugins {{{
Plug 'PeterRincker/vim-argumentative'
Plug 'godlygeek/tabular'
Plug 'michaeljsmith/vim-indent-object'
Plug 'qpkorr/vim-renamer', { 'on': 'Renamer' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" }}}

" Add locally-defined plugins
runtime local/vim-plug.vim

call plug#end()

" }}}

" General settings {{{

set nocompatible
set history=1000
set iskeyword+=-

" better commandline completion
set wildmode=longest,list,full
set wildmenu

" Set color scheme
set background=dark
colorscheme base16-eighties
let g:airline_theme = "base16_eighties"
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use 'Silent' for supressing 'Hit Enter to continue' prompt
command! -nargs=1 Silent
      \ | execute ':silent !'.<q-args>
      \ | execute ':redraw!'

" }}}

" Key bindings {{{

" Set leader key
let g:mapleader = "\<space>"

" Lazier versions of 'copy all' and 'delete all'
nmap <leader>5y :%y<cr>
nmap <leader>5Y :%y +<cr>
nmap <leader>5d :%d<cr>
nmap <leader>5D :%d +<cr>

" Quickly toggle line numbers
nmap <leader>n :set number!<cr>
nmap <leader>N :set relativenumber!<cr>

" :WW sudo saves the file with root permissions
command WW w !sudo tee % > /dev/null

" Clipboard (yank/put into system clipboard)
map <leader>y "+y
map <leader>d "+d
map <leader>p "+p
map <leader>P "+P

" Folding
" Double-click left mouse to open/close folds
nnoremap <2-LeftMouse> za
" Make parent fold moves more intuitive
nnoremap zK [z
nnoremap zJ ]z

" bypass that pesky shift key
command W write
command Q quit
command Wq wq
command WQ wq

" Remaps the macro record key 'q' to 'Q' instead
nnoremap Q q
nnoremap q <Nop>

" Remap ' key (duplicated in ` anyway)
noremap ' "
" List registers
noremap '' :registers<cr>

" Disable highlight when <Esc><Esc> is pressed
nmap <silent> <Esc><Esc> :noh<cr>

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

" git keybindings (both vim-fugitive and vim-gitgutter)
nmap <leader>ga :w<cr>:silent Git add %<cr>
nmap <leader>ha <Plug>(GitGutterStageHunk)
nmap <leader>hr <Plug>(GitGutterUndoHunk)
nmap <leader>hn <Plug>(GitGutterNextHunk)
nmap <leader>hp <Plug>(GitGutterPrevHunk)
nmap <leader>gc :Git commit<cr>

" redraw screen (for nvim window-resize bug)
nnoremap <leader>r :redraw!<cr>

" }}}

" Plugin settings {{{

" UndoTree settings {{{
nnoremap <leader>u :UndotreeShow<CR>:UndotreeFocus<CR>
au FileType undotree nnoremap <buffer> <leader>u :UndotreeHide<CR>
" }}}

" NERDtree settings {{{
" main maps
nnoremap <Tab> :NERDTreeFocus<CR>
au FileType nerdtree nnoremap <buffer> <Tab> :NERDTreeClose<CR>
nnoremap <C-o> :NERDTreeFind<CR>
" internal maps
let g:NERDTreeMapPreview='O'
let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapPreviewSplit='S'
let g:NERDTreeMapOpenVSplit='v'
let g:NERDTreeMapPreviewVSplit='V'
" options
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeMouseMode = 1
let g:NERDTreeWinSize = 41
let g:NERDTreeShowHidden = 1
" }}}

" vim-json settings {{{
set conceallevel=0 " Disable character concealing
let g:vim_json_syntax_conceal = 0 " Force no concealing for json files
" }}}

" vim-airline settings {{{
set timeoutlen=500 " Set timeout for statusline redraw on escape
au BufWritePost * AirlineRefresh
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_nr = 1 " show tab numbers
let g:airline#extensions#tabline#tab_nr_type = 1 " show only tab number
let g:airline#extensions#tabline#formatter = "unique_tail_improved"
let g:airline#extensions#whitespace#enabled = 0 " disable whitespace checking
let g:airline_inactive_collapse = 0
let g:airline#extensions#branch#format = 2 " truncate git branch paths
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#wordcount#enabled = 0
au VimEnter * let g:airline_section_b = airline#section#create(['windowswap', '%<', '%f%m', 'readonly'])
au VimEnter * let g:airline_section_c = airline#section#create(['filetype'])
au VimEnter * let g:airline_section_x = airline#section#create(['%3p%%'])
au VimEnter * let g:airline_section_y = airline#section#create(['hunks'])
au VimEnter * let g:airline_section_z = airline#section#create(['branch'])
let g:airline#extensions#default#section_truncate_width = {}
  let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'SL',
      \ ''     : 'SB',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'VL',
      \ ''     : 'VB',
      \ }
let g:airline_filetype_overrides = {
      \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
      \ 'gundo': [ 'Gundo', '' ],
      \ 'help':  [ 'Help', '%f' ],
      \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
      \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
      \ 'startify': [ 'startify', '' ],
      \ 'vim-plug': [ 'Plugins', '' ],
      \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
      \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
      \ }
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.dirty=''
let g:airline_symbols.notexists=''
let g:airline_symbols.readonly = ' '
au VimEnter * AirlineRefresh
" }}}

" vim-gitgutter settings {{{
set updatetime=100  " 100ms refresh time
set signcolumn=yes
let g:gitgutter_max_signs = 10000
set numberwidth=1 " reduce extra spaces between signs and line numbers
" }}}

" tig-explorer settings {{{
nnoremap <Leader>gl :TigOpenProjectRootDir<CR>
nnoremap <Leader>gL :TigOpenCurrentFile<CR>
nnoremap <Leader>gg :TigGrep<CR>
nnoremap <Leader>ggr :TigGrepResume<CR>
vnoremap <Leader>gg y:TigGrep<Space><C-R>"<CR>
nnoremap <Leader>gb :TigBlame<CR>
nnoremap <Leader>gs :TigStatus<CR>
" }}}

" vim-easymotion settings {{{
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>j <Plug>(easymotion-j)
map <leader><leader>k <Plug>(easymotion-k)
map <leader><leader>h <Plug>(easymotion-linebackward)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" }}}

" neomake settings {{{
autocmd! BufWritePost * Neomake

let g:neomake_open_list = 0
let g:neomake_verbose = 0

let g:neomake_sh_enabled_makers = ['shellcheck']
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_chef_enabled_makers = ['foodcritic']

" Move to prev/next location in LocationList window (used below)
function! <SID>LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  catch /^Vim\%((\a\+)\)\=:E42/
  catch /^Vim\%((\a\+)\)\=:E776/
  endtry
endfunction
function! <SID>LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  catch /^Vim\%((\a\+)\)\=:E42/
  catch /^Vim\%((\a\+)\)\=:E776/
  endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> <leader>[    <Plug>LocationPrevious
nmap <silent> <leader>]    <Plug>LocationNext

" }}}

" deoplete settings {{{
let g:deoplete#enable_at_startup = 1
set completeopt+=noinsert,noselect
" use ctrl-j and ctrl-k to navigate auto-complete suggestion list
inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
imap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>\<Plug>DiscretionaryEnd" : "\<CR>\<Plug>DiscretionaryEnd")
" highlight trailing whitespaces
function! s:is_whitespace()
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~? '\s'
endfunction
" }}}

" python-mode settings {{{
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_doc = 1
let g:pymode_run = 0
let g:pymode_trim_whitespaces = 0
" }}}

" simpylFold settings {{{
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_import = 0
" }}}

" BufExplorer settings {{{
nmap <silent> <Leader>b :ToggleBufExplorer<cr> g:pymode_rope_completion = 0
let g:bufExplorerFindActive=0
" }}}

" fzf settings {{{
nnoremap <c-t> :Files<cr>
nnoremap <c-f> :BLines<cr>
nnoremap <c-g> :GitFiles<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap ``` :Marks<cr>
let g:fzf_layout = { 'window': 'new' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
" }}}

" vim-gist settings {{{
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
" }}}

" vim-stay settings {{{
set viewoptions=cursor,folds,slash,unix
" }}}

" vim-better-whitespace settings {{{
command CurrentLineWhitespaceOff soft
" }}}

" vim-terraform settings {{{
let g:terraform_align = 1
let g:terraform_fmt_on_save = 0
" }}}

" vim-markdown-folding settings {{{
let g:markdown_fold_style = 'nested'
" }}}

" vim-markdown-preview settings {{{
let g:vim_markdown_preview_hotkey='<leader>gp'
let g:vim_markdown_preview_github=1
" }}}

" open-browser-github settings {{{
let g:openbrowser_github_url_exists_check = 0
let g:openbrowser_github_always_use_commit_hash = 0
nmap <leader>go :OpenGithub
" }}}

" indentLine settings {{{
let g:indentLine_char = '│' " UTF-8 font required
let g:indentLine_concealcursor = ''
let g:indentLine_fileTypeExclude = ['Help']
let g:indentLine_bufTypeExclude = ['terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*']
" }}}

" git rebase settings {{{
let g:auto_git_diff_show_window_at_right = 1
function! s:setup_git_rebase_maps() abort

  " movement
  nnoremap <buffer> J j
  nmap <buffer> <C-e> <Plug>(auto_git_diff_scroll_down_1)
  nmap <buffer> <C-d> <Plug>(auto_git_diff_scroll_down_half)
  nnoremap <buffer> K k
  nmap <buffer> <C-y> <Plug>(auto_git_diff_scroll_up_1)
  nmap <buffer> <C-u> <Plug>(auto_git_diff_scroll_up_half)

  " commit actions
  map <buffer> <leader>p :Pick<CR>
  map <buffer> <leader>r :Reword<CR>
  map <buffer> <leader>e :Edit<CR>
  map <buffer> <leader>s :Squash<CR>
  map <buffer> <leader>f :Fixup<CR>
  map <buffer> <leader>d :Drop<CR>

endfunction
autocmd FileType gitrebase call <SID>setup_git_rebase_maps()
" }}}
" }}}

" User interface {{{

" Set some built-in settings
set number " show line numbers
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
set cursorline " Highlight current line
set noshowmode " Disable --INSERT-- text in command line. Reproduced in airline
set foldenable " Enable folding
set foldmethod=syntax " Default to syntax folding
set undofile " Save per-file undo history between sessions

" }}}

" Text, tab and indent related {{{

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
set textwidth=0
set colorcolumn=+1,+21,+41

" Define text expansions
iabbrev ube# #!/usr/bin/env
inoremap ds""  """<CR>"""O
inoremap ds`` ```<CR>```O

" executes current file (if executable)
nnoremap <leader>x :!%:p<cr>

" }}}

" Per-filetype settings {{{

" Misc {{{
au BufRead,BufNewFile *.link   setlocal ft=
au BufRead,BufNewFile term://* setlocal nocursorline colorcolumn=0
" }}}

" Make {{{
au FileType make setlocal noexpandtab
" }}}

" vim {{{
au FileType vim setlocal tw=0
" }}}

" config files {{{
au FileType dosini,cfg,conf setlocal cms=#\ %s
" }}}

" Shell {{{
au FileType sh setlocal fdm=syntax sw=2 tw=0 colorcolumn=80,100,120
au FileType sh let g:sh_fold_enabled=7
" }}}

" Terraform {{{
au FileType           terraform setlocal tw=0 sw=2 fdm=syntax
au BufRead,BufNewFile *.tpl     setlocal ft=
" }}}

" Markdown {{{
au FileType markdown setlocal textwidth=0 shiftwidth=4 spell
" }}}

" Ruby {{{
au BufRead,BufNewFile {Berksfile,Vagrantfile,Gemfile} setlocal filetype=ruby
au BufRead,BufNewFile {.Brewfile,Brewfile}            setlocal filetype=ruby
au BufRead,BufNewFile *.pp                            setlocal filetype=ruby
" }}}

" Git {{{
au BufRead,BufNewFile COMMIT_EDITMSG  normal ggjO
au BufEnter           COMMIT_EDITMSG  call setpos('.', [0, 1, 1, 0])
au BufRead,BufNewFile PULLREQ_EDITMSG setlocal ft=ghmarkdown cms=\%%s tw=0 spell fdl=99
au BufRead,BufNewFile PULLREQ_EDITMSG nnoremap <leader>gp :call Vim_Markdown_Preview()<cr>
au FileType           gitcommit       setlocal tw=72 cms=\%%s colorcolumn=+1,51 spell fdl=99
" }}}

" Python {{{
au FileType python setlocal sw=4 ts=4 tw=0 colorcolumn=80,100,120
au FileType python imap <C-p> import pdb; pdb.set_trace()
au FileType python imap <C-o> import IPython; IPython.embed()
" }}}

" YAML {{{
au BufRead,BufNewFile {*.yml.tpl,*.yaml.tpl} setlocal filetype=yaml
au FileType yaml setlocal fdl=99
" }}}

" JSON {{{
au FileType json setlocal fdl=99
" }}}

" }}}

" Moving around, tabs, windows and buffers {{{

" Treat long lines as break lines (useful when moving around in them)
"map j gj
"map k gk

" remap pane-movement keys
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" remap Terminal exit binding for nvim
tnoremap <leader><Esc> <C-\><C-n>

" better split placements
set splitbelow
set splitright

" tab shortcuts
map <leader>t  :tabnew<cr>
map <leader>th :tabnext<cr>
map <leader>tl :tabprevious<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt

" Open new splits
nnoremap <C-w>- :sp<cr>
nnoremap <C-w>\ :vsp<cr>

" Zoom window
nnoremap <C-w>+ <C-w>\|<C-w>_

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

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

" }}}

" Status line {{{
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

" Statusline to be used when Airline is not loaded
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


" }}}

" Functions {{{
" these functions are likely used elsewhere in this config

function! ThreeFingerClaw()
  exe "normal! oyell() { echo \"$0: $*\" >&2; }"
  exe "normal! odie() { yell \"$*\"; exit 111; }"
  exe "normal! otry() { \"$@\" || die \"cannot $*\"; }"
endfunction

" show highlight group for what's under the cursor
function! ShowHiCursor()
  echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction

function! Dot()
  let $GIT_DIR = $HOME . "/.dotfiles_git"
  let $GIT_WORK_TREE = $HOME
endfunction
command Dot call Dot()

function! Ldot()
  let $GIT_DIR = $HOME . "/.dotfiles_git_local"
  let $GIT_WORK_TREE = $HOME
endfunction
command Ldot call Ldot()

function! VisualSelection(direction, extra_filter) range "{{{
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
endfunction " }}}

" }}}

" Load local config (if it exists)
runtime local/init.vim

" Enable syntax highlighting (should always be last)
syntax enable