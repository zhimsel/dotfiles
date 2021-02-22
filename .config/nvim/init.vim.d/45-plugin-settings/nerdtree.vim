" key maps
" <C-i> is <Tab>
nnoremap <C-i> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <C-o> :NERDTreeFind<CR>

augroup nerdtree
  autocmd!

  " <Tab> will close NERDTree when it's the active window
  autocmd FileType nerdtree nnoremap <buffer> <C-i> :NERDTreeClose<CR>

  " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
  autocmd BufEnter *
        \ if bufname('#') =~ 'NERD_tree_\d\+'
        \ && bufname('%') !~ 'NERD_tree_\d\+'
        \ && winnr('$') > 1
        \ | let buf=bufnr()
        \ | buffer#
        \ | execute "normal! \<C-W>w"
        \ | execute 'buffer'.buf
        \ | endif

augroup END

" internal maps
let g:NERDTreeMapPreview='O'
let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapPreviewSplit='S'
let g:NERDTreeMapOpenVSplit='v'
let g:NERDTreeMapPreviewVSplit='V'

" options
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeHijackNetrw=1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 31

" Always open files in current window; don't switch to it if it's already open
let g:NERDTreeCustomOpenArgs = {
      \ 'file': {'where': 'p', 'reuse': '', 'keepopen': 1 },
      \ 'dir': {}
      \ }
