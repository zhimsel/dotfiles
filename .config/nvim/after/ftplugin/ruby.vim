" Insert pry binding
inoremap <C-b> require 'pry'; binding.pry
let b:undo_ftplugin .= '| iunmap <C-b>'

" https://github.com/vim-ruby/vim-ruby/issues/249
let g:ruby_indent_assignment_style = 'variable'
