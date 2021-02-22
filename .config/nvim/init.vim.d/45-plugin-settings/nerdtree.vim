" key maps
" <C-i> is <Tab>
nnoremap <C-i> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <C-o> :NERDTreeFind<CR>

augroup nerdtree
  autocmd!
  autocmd FileType nerdtree nnoremap <buffer> <C-i> :NERDTreeClose<CR>
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
let g:NERDTreeQuitOnOpen = 3
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 41

" Always open files in current window; don't switch to it if it's already open
let g:NERDTreeCustomOpenArgs = {'file': {'where': 'p', 'reuse': ''}, 'dir': {}}
