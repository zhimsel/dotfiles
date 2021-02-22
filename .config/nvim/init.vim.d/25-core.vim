" Core settings {{{

" Backend 'system' settings {{{
filetype plugin on " Enable filetype plugins
set ffs=unix,dos,mac " Use Unix as the standard file type
set guicursor= " disable changing cursor shape
set hidden " A buffer becomes hidden when it is abandoned
set history=1000 " Store a longer command history
set lazyredraw " Don't redraw while executing macros (good performance config)
set redrawtime=10000 " Longer for large files' syntax highlighting
set mouse=ar " Enable mouse interaction
set timeoutlen=500 " Set timeout for completing keymaps
set undofile " Save per-file undo history between sessions
set updatetime=100  " how quickly to write the swapfile after typing stops
set viewoptions=cursor,folds,slash,unix " what to save in session files (and for vim-stay)
" }}}

" Status line {{{
set cmdheight=1 " Height of the command bar
set noshowmode " Disable --INSERT-- text in command line. Reproduced in airline
set report=0 " tell us about changes
set shortmess+=I " Disable welcome message
set showcmd " show (partial) command in status line
" }}}

" Sign column and line display {{{
set cursorline " Highlight current line
set number " show line numbers
set numberwidth=4  " minimum width of the number column
set signcolumn=auto:4  " show sign column left of line numbers (for gitgutter, linting, etc)
" }}}

" Searching {{{
set hlsearch " Highlight search results
set ignorecase " Ignore case when searching
set incsearch " Makes search act like search in modern browsers
set magic " For regular expressions turn magic on
set matchpairs+=<:> " Highlight extra matched pairs
set matchtime=2 " How many tenths of a second to blink when matching brackets
set showmatch " Show matching brackets when text indicator is over them
set smartcase " When searching try to be smart about cases
" }}}

" Folding {{{
set foldenable
set foldlevelstart=999 " Start with all folds open
set foldmethod=syntax " Default to syntax folding
" }}}

" Defaults for tab width {{{
set expandtab
set shiftwidth=0 " set to 0, will use value of tabstop
set smarttab
set tabstop=2
" }}}

" Auto-indenting/breaking {{{
filetype indent on " Enable filetype-specific indenting
set autoindent
set colorcolumn=81,101,121
set linebreak
set nolist
set textwidth=0
set whichwrap+=<,>,h,l " Wrap lines on movement for 'h/l' keys
set wrap
set nojoinspaces
" }}}

" Completion {{{
set completeopt+=noinsert,noselect
set wildmenu
set wildmode=longest,list,full
" }}}

" Movement {{{
set backspace=eol,start,indent " Configure backspace so it acts more intuitively
set iskeyword+=- " Word separators
set nostartofline " don't jump to start of line when scrolling
set scrolloff=7 " Set 7 lines to the cursor - when moving vertically using j/k
" }}}

" Windows {{{
set splitbelow
set splitright
" }}}

" }}}

" Visual/theme {{{

" Set color scheme {{{
set background=dark

colorscheme base16-eighties
let g:airline_theme = "base16_eighties_custom"

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" }}}

" Fix MatchParens highlighting in comments with base16 colorschemes {{{
function! s:base16_customize() abort
  call Base16hi("MatchParen", g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold,italic", "")
endfunction
augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END
" }}}

" Highlight yanked text (requires neovim 0.5+) {{{
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
augroup END
" }}}

" }}}
