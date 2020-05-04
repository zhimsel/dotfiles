" vim:foldmethod=marker

" This file is written with vim foldmarkers to enable easier viewing
" It's designed to be viewed/edited from within vim. Each section has
" fold markers at the beginning and end, so you can easily close each
" section to find what you're looking for

" Written by Zach Himsel, 2013-present
" https://github.com/zhimsel/dotfiles


" Plugins {{{

let g:plug_window = 'enew'
runtime vim-plug/plug.vim  " managed externally (via dotfiles submodules)
call plug#begin(stdpath('data') . '/vim-plug')

" Visual plugins {{{
Plug 'airblade/vim-gitgutter'  " git diff symbols in sign column
Plug 'chriskempson/base16-vim'  " better themes
Plug 'ntpeters/vim-better-whitespace'  " highlight trailing whitespaces
Plug 'vim-airline/vim-airline'  " better statusbar
Plug 'vim-airline/vim-airline-themes'  " themese for Airline
Plug 'Xuyuanp/nerdtree-git-plugin'  " show git status symbols in NERDTree
Plug 'Yggdroot/indentLine'  " visual marker for indent level
" }}}

" Extending/improving the base interface {{{
Plug 'git@github.com:zhimsel/vim-stay.git', { 'dir': '~/dev/vim-stay', 'frozen': 'true' }  " save and restore view when closing file buffers
Plug 'godlygeek/tabular'  " column-align text
Plug 'iberianpig/tig-explorer.vim'  " use tig for many git operations (log, status, blame, etc)
Plug 'jlanzarotta/bufexplorer'  " interactive buffer management
Plug 'junegunn/fzf.vim'  " fuzzy-finding all sorts of things (files, buffers, lines, etc)
Plug 'kana/vim-textobj-fold'  " use folds as text objects
Plug 'kassio/neoterm'  " open terminal easily
Plug 'Lokaltog/vim-easymotion'  " improved motions with skipping objects
Plug 'mattn/gist-vim'  " save current buffer/selection as a Github gist
Plug 'mbbill/undotree'  " visual selection of entire undo tree for a file
Plug 'preservim/nerdtree'  " file/directory explorer
Plug 'tpope/vim-abolish'  " improved search/replace with case-specific behavior
Plug 'tpope/vim-fugitive'  " lots of git commands/shortcuts
Plug 'tyru/open-browser-github.vim'  " open commits/files/etc in Github
Plug 'wellle/targets.vim'  " additional text objects
Plug 'wesQ3/vim-windowswap'  " swap two panes easily
" }}}

" Automating repetitive tasks  {{{
Plug 'michaeljsmith/vim-indent-object'  " use indent levels as text objects
Plug 'PeterRincker/vim-argumentative' " manipulate function arguments
Plug 'qpkorr/vim-renamer', { 'on': 'Renamer' }  " batch-rename files in vim
Plug 'tpope/vim-commentary'  " comment/uncomment lines automatically
Plug 'tpope/vim-endwise'  " automatic if/for/etc block closing
Plug 'tpope/vim-eunuch'  " useful shell commands
Plug 'tpope/vim-repeat'  " improved repeats
Plug 'tpope/vim-surround'  " add/remove/modify surrounding brackets/quotes/etc
" }}}

" Autocompletion/linting {{{
Plug 'benekastah/neomake'  " automated linting
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  " word completion
" }}}

" Filetype-specific plugins {{{
Plug 'elzr/vim-json'  " JSON syntax/etc
Plug 'hashivim/vim-terraform'  " Terraform syntax/etc
Plug 'hotwatermorning/auto-git-diff'  " show commit diff for interactive rebases
Plug 'jtratner/vim-flavored-markdown'  " Github-flavored markdown (used for git commits, PRs, etc)
Plug 'masukomi/vim-markdown-folding'  " Better folding for Markdown
Plug 'pedrohdz/vim-yaml-folds'  " Better folding for YAML
Plug 'tmhedberg/SimpylFold'  " Better folding for Python
Plug 'tpope/vim-git'  " Syntax/etc for git files (commit messages, etc)
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }  " Syntax/etc for Ruby
Plug 'zhimsel/vim-markdown-preview', { 'for': ['markdown', 'ghmarkdown'], 'branch': 'default_browser_assumption' }  " Open a Github-flavored rendered preview of a Markdown file in the browser
" }}}

" Dependencies {{{
Plug 'junegunn/fzf'  " required by: junegunn/fzf.vim
Plug 'kana/vim-textobj-user'  " required by: kana/vim-textobj-fold
Plug 'mattn/webapi-vim'  " required by: mattn/gist-vim
Plug 'tyru/open-browser.vim'  " open URLs in browser; required by: tyru/open-browser-github.vim
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

" Use 'Silent' for supressing 'Hit Enter to continue' prompt
command! -nargs=1 Silent
      \ | execute ':silent !'.<q-args>
      \ | execute ':redraw!'

" }}}

" Key bindings {{{

" Set leader key
let g:mapleader = "\<space>"

" :WW sudo saves the file with root permissions
command WW SudoWrite
command EE SudoEdit

" Folding
" Double-click left mouse to open/close folds
nnoremap <2-LeftMouse> za
" Make parent fold moves more intuitive
nnoremap zK [z
nnoremap zJ ]z

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

" vim-airline settings {{{
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

function! AirlineSectionInit()
  let g:airline_section_b = airline#section#create(['windowswap', '%<', '%f%m', 'readonly'])
  let g:airline_section_c = airline#section#create(['filetype'])
  let g:airline_section_x = airline#section#create(['%3p%%'])
  let g:airline_section_y = airline#section#create(['hunks'])
  let g:airline_section_z = airline#section#create(['branch'])
endfunction

au User AirlineAfterInit call AirlineSectionInit()
" }}}

" vim-gitgutter settings {{{
let g:gitgutter_max_signs = 10000
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

" <C-_> maps to Ctrl-/ (for some reason)
map  <C-_> <Plug>(easymotion-sn)
omap <C-_> <Plug>(easymotion-tn)

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

" vim-better-whitespace settings {{{
let g:current_line_whitespace_soft = 1
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

" open-browser settings {{{
vmap <leader>o <Plug>(openbrowser-smart-search)
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

" User interface settings {{{

" TODO: organize this better
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
set timeoutlen=500 " Set timeout for completing keymaps
set updatetime=100  " how quickly to write the swapfile after typing stops
set signcolumn=yes  " show sign column left of line numbers (for gitgutter, linting, etc)
set numberwidth=1 " reduce extra spaces between signs and line numbers
set completeopt+=noinsert,noselect  " set completion rules
set viewoptions=cursor,folds,slash,unix  " what to save in session files (and for vim-stay)

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable filetype plugins
filetype plugin indent on

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

" Define some text expansions
iabbrev ube# #!/usr/bin/env
inoremap ds""  """<CR>"""O
inoremap ds`` ```<CR>```O

" }}}

" Per-filetype settings {{{

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
au FileType sh setlocal sw=2 tw=0 colorcolumn=80,100,120
au FileType sh let g:sh_fold_enabled=7
" }}}

" Terraform {{{
au FileType           terraform setlocal tw=0 sw=2
" Terraform templates
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
map <leader>tc :tabclose<cr>
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt

" Open new splits
nnoremap <C-w>- :sp<cr>
nnoremap <C-w>\ :vsp<cr>

" Zoom window
nnoremap <C-w>+ <C-w>\|<C-w>_

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

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
