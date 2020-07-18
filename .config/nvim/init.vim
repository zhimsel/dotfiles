" Load init files from init.vim.d directories
runtime! init.vim.d/**/*.vim

" Set foldmethod to marker for all nvim config files
augroup nvim_config
  autocmd!
  autocmd BufRead,BufNewFile */init.vim.d/*.vim setlocal foldmethod=marker
augroup END
