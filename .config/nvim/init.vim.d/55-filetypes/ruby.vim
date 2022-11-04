augroup filetype_ruby autocmd!

  autocmd BufRead,BufNewFile
        \ {.,}{Berks,Vagrant,Gem,Brew}file,*.pp
        \ setlocal filetype=ruby

  " Insert pry binding
  autocmd FileType ruby inoremap <C-b> require 'pry'; binding.pry

  " https://github.com/vim-ruby/vim-ruby/issues/249
  autocmd FileType ruby let g:ruby_indent_assignment_style = 'variable'

augroup END
