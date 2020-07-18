nnoremap <c-t> :Files<cr>
nnoremap <c-f> :BLines<cr>
nnoremap <c-g> :GitFiles<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap ```   :Marks<cr>

let g:fzf_layout = {
  \ 'window': {
    \ 'width': 0.9,
    \ 'height': 0.8
  \ }
\ }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\ }

augroup fzf
  autocmd!
  autocmd FileType fzf tnoremap <buffer> <esc> <c-c>
augroup END
