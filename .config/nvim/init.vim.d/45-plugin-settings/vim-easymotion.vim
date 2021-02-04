let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>j <Plug>(easymotion-j)
map <leader><leader>k <Plug>(easymotion-k)
map <leader><leader>h <Plug>(easymotion-linebackward)

" <C-_> maps to Ctrl-/
noremap  <C-_> /
onoremap <C-_> /
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
