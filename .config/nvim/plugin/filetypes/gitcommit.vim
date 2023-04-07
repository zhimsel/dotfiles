augroup filetype_commit_editmsg autocmd!

  " Move cursor to top of file when opening commit message
  autocmd BufRead,BufNewFile COMMIT_EDITMSG normal ggjO
  autocmd BufRead,BufNewFile COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

augroup END
