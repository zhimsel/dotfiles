augroup filetype_ruby autocmd!

  autocmd BufRead,BufNewFile
        \ {.,}{Berks,Vagrant,Gem,Brew}file,*.pp
        \ setlocal filetype=ruby

augroup END
