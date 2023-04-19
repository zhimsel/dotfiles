augroup filetype_terminal autocmd!

  " automatically enter "insert" mode when opening a terminal
  autocmd TermOpen * startinsert

  " set some terminal-specific options
  autocmd TermOpen * setlocal
        \ nonumber
        \ norelativenumber
        \ nocursorline
        \ signcolumn=no

  " automatically close terminal buffer when it exits 0
  autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif

augroup END
