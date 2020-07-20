augroup filetype_helm autocmd!

  autocmd BufRead,BufNewFile _helpers.tpl setlocal
        \ filetype=yaml

augroup END
