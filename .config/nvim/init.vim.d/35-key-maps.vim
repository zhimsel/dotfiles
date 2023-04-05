" vim: set foldmethod=marker

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
nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

" Open new windows
nnoremap <C-w>- :sp<cr>
nnoremap <C-w>\ :vsp<cr>

" Zoom window
nnoremap <C-w>+ <C-w>\|<C-w>_

" Create and switch to tabs more easily
nnoremap <C-w>t  :tabnew<cr>
nnoremap <C-w>T  :tab split<cr>
nnoremap <C-w>tc :tabclose<cr>

" Switch the CWD to the directory of the open buffer
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Remap terminal exit
tnoremap <leader><Esc> <C-\><C-n>

" Open split terminal in current directory
command! -nargs=* Term split | terminal <args>
nnoremap <silent> <leader>t :Term<CR>

" Open split terminal in current file's directory
command! -nargs=* TermHere split | lcd %:p:h | terminal <args>
nnoremap <silent> <leader>T :TermHere<CR>

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

" Send most-recently-yanked register to system clipboard
nnoremap <leader>y :let @+=@"<CR>
nnoremap <leader>Y :%y +<CR>

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

" Keep cursor position when joining lines
nnoremap J m`J``

" }}}

" Motion {{{

" In visual mode, move to first/last line of paragraph (useful for visual block)
vnoremap <silent> [ :<C-U>call cursor(line("'{")-1,col("'>"))<CR>`<1v``
vnoremap <silent> ] :<C-U>call cursor(line("'}")-1,col("'>"))<CR>`<1v``

" Select recently-pasted text
nnoremap gp `[v`]

" }}}

" Jumping {{{

" Remap Ctrl-i/o jump maps (Used for NERDtree)
nnoremap [j <C-o>
nnoremap ]j <C-i>

" }}}

" Git {{{

nmap <leader>ha  <Plug>(GitGutterStageHunk)
nmap <leader>hp  <Plug>(GitGutterPreviewHunk)
nmap <leader>hr  <Plug>(GitGutterUndoHunk)

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

    nmap <silent> [l <Plug>LocationPrevious
    nmap <silent> ]l <Plug>LocationNext
nnoremap <silent> <leader>l :lopen<CR>

" }}}
