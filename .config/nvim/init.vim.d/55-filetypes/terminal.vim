augroup filetype_terminal autocmd!

  " automatically enter "insert" mode when opening a terminal
  autocmd TermOpen * startinsert

  " automatically close terminal buffer when it exits 0
  autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif

augroup END
