augroup neomake
  autocmd!
  autocmd BufWritePost * Neomake
augroup END

let g:neomake_open_list = 0
let g:neomake_verbose = 0

let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_sh_enabled_makers = ['shellcheck']
