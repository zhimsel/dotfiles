" Set leader key
let g:mapleader = "\<space>"

" Misc {{{

" Disable highlight when <Esc><Esc> is pressed
nnoremap <silent> <Esc><Esc> :noh<cr>

" Redraw screen (for nvim window-resize bug)
nnoremap <leader>r :redraw!<cr>

" Reload nvim config
command! Reload source $MYVIMRC
nnoremap <leader>R :Reload<cr>

" }}}

" Buffers, windows, and tabs {{{

" Switch windows more easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open new windows
nnoremap <C-w>- :sp<cr>
nnoremap <C-w>\ :vsp<cr>

" Zoom window
nnoremap <C-w>+ <C-w>\|<C-w>_

" Create and switch to tabs more easily
nnoremap <C-w>t  :tabnew<cr>
nnoremap <C-w>tc :tabclose<cr>
nnoremap <C-w>1 1gt
nnoremap <C-w>2 2gt
nnoremap <C-w>3 3gt
nnoremap <C-w>4 4gt
nnoremap <C-w>5 5gt
nnoremap <C-w>6 6gt
nnoremap <C-w>7 7gt
nnoremap <C-w>8 8gt
nnoremap <C-w>9 9gt

" Switch the CWD to the directory of the open buffer
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Remap terminal exit
tnoremap <leader><Esc> <C-\><C-n>

" Read/write buffer with root permissions
command! WW SudoWrite
command! EE SudoEdit

" }}}

" Folding {{{

" Middle-click mouse to open/close folds
nnoremap <silent> <MiddleMouse> <LeftMouse>za

" Make parent fold moves more intuitive
nnoremap zK [z
nnoremap zJ ]z

" }}}

" Registers {{{

" Use ' as " (which is duplicated in ` anyway)
map ' "

" Send most-recently-yanked register to system clipboard
nnoremap <leader>y :let @+=@"<CR>

" Toggle 'paste'
nnoremap <silent> <leader>p :set paste!<CR>

" }}}

" Manipulating text {{{

" Move lines up/down
nnoremap <silent> <Down> :m+<CR>==
vnoremap <silent> <Down> :m '>+1<CR>gv=gv
nnoremap <silent> <Up>   :m-2<CR>==
vnoremap <silent> <Up>   :m '<-2<CR>gv=gv

" Move selected text left/right
nnoremap <silent> <Right> xp`[v`]
vnoremap <silent> <Right> xp`[v`]
nnoremap <silent> <Left>  xhhp`[v`]
vnoremap <silent> <Left>  xhhp`[v`]

" }}}

" Motion {{{

" In visual mode, move to first/last line of paragraph (useful for visual block)
vnoremap <silent> [ :<C-U>call cursor(line("'{")-1,col("'>"))<CR>`<1v``
vnoremap <silent> ] :<C-U>call cursor(line("'}")-1,col("'>"))<CR>`<1v``

" }}}

" Jumping {{{

" Remap Ctrl-i/o jump maps (Used for NERDtree)
nnoremap <leader>j[ <C-o>
nnoremap <leader>j] <C-i>

" }}}

" Git {{{

nnoremap <leader>ga  :w<cr>:silent Git add -f %<cr>
nnoremap <leader>gb  :TigBlame<CR>
nnoremap <leader>gc  :Git commit<cr>
nnoremap <leader>gg  :TigGrep<CR>
nnoremap <leader>ggr :TigGrepResume<CR>
nnoremap <leader>gL  :TigOpenCurrentFile<CR>
nnoremap <leader>gl  :TigOpenProjectRootDir<CR>
nnoremap <leader>gs  :TigStatus<CR>
    nmap <leader>ha  <Plug>(GitGutterStageHunk)
    nmap <leader>hp  <Plug>(GitGutterPreviewHunk)
    nmap <leader>hr  <Plug>(GitGutterUndoHunk)
vnoremap <leader>gg  :TigGrep<Space><C-R>"<CR>

" }}}

" Interacting with quickfix/locationlist window {{{

" Move to prev/next location in LocationList window
function! <SID>LocationPrevious() " {{{
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  catch /^Vim\%((\a\+)\)\=:E42/
  catch /^Vim\%((\a\+)\)\=:E776/
  endtry
endfunction " }}}
function! <SID>LocationNext() " {{{
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  catch /^Vim\%((\a\+)\)\=:E42/
  catch /^Vim\%((\a\+)\)\=:E776/
  endtry
endfunction " }}}
nmap <silent> <Plug>LocationPrevious :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nmap <silent> <Plug>LocationNext     :<C-u>exe 'call <SID>LocationNext()'<CR>

    nmap <silent> <leader>[ <Plug>LocationPrevious
    nmap <silent> <leader>] <Plug>LocationNext
nnoremap <silent> <leader>\ :lopen<CR>

" }}}
