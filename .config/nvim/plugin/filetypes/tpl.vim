augroup filetype_tpl autocmd!

  " Don't set filetype for template files
  autocmd BufRead,BufNewFile *.tpl setlocal filetype=

augroup END
