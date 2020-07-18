augroup filetype_cfg autocmd!

  autocmd FileType dosini,cfg,conf setlocal
    \ commentstring=#\ %s

augroup END
