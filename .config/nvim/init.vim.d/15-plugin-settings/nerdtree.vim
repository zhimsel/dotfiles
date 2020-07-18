" key maps
nnoremap <Tab> :NERDTreeFocus<CR>
nnoremap <C-o> :NERDTreeFind<CR>

augroup nerdtree
  autocmd!
  autocmd FileType nerdtree nnoremap <buffer> <Tab> :NERDTreeClose<CR>
augroup END

" internal maps
let g:NERDTreeMapPreview='O'
let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapPreviewSplit='S'
let g:NERDTreeMapOpenVSplit='v'
let g:NERDTreeMapPreviewVSplit='V'

" options
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 1
let g:NERDTreeQuitOnOpen = 3
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 41
