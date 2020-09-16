augroup filetype_ruby autocmd!

  autocmd BufRead,BufNewFile
        \ {.,}{Berks,Vagrant,Gem,Brew}file,*.pp
        \ setlocal filetype=ruby

  " Insert pry binding
  autocmd FileType ruby inoremap <C-b> require 'pry'; binding.pry

augroup END
