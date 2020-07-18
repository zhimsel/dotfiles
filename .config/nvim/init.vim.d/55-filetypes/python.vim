augroup filetype_python autocmd!

  autocmd FileType python setlocal
        \ tabstop=4

  " Insert pdb breaks
  autocmd FileType python inoremap <C-p> import pdb; pdb.set_trace()
  autocmd FileType python inoremap <C-o> import IPython; IPython.embed()

augroup END
