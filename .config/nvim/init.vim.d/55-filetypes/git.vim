augroup filetype_git autocmd!

  " Move cursor to top of file when opening commit message
  autocmd BufRead,BufNewFile COMMIT_EDITMSG normal ggjO
  autocmd BufRead,BufNewFile COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " Commit messages
  autocmd FileType gitcommit setlocal
        \ colorcolumn=+1,51
        \ commentstring=\%%s
        \ spell
        \ textwidth=72

  " Pull Requests
  autocmd BufRead,BufNewFile PULLREQ_EDITMSG setlocal
        \ commentstring=\%%s
        \ filetype=markdown
        \ spell

augroup END
