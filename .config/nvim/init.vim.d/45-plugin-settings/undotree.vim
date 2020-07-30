nnoremap <leader>u :UndotreeShow<CR>:UndotreeFocus<CR>

augroup undotree
  autocmd!
  autocmd FileType undotree nnoremap <buffer> <leader>u :UndotreeHide<CR>
augroup END
