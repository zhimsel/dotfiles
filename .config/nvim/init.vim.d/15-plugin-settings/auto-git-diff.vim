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

augroup git_rebase
  autocmd!
  autocmd FileType gitrebase call <SID>setup_git_rebase_maps()
augroup END
