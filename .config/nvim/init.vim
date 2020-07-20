" Load init files from init.vim.d directories
runtime! init.vim.d/**/*.vim

" Set foldmethod to marker for all config files
augroup dotfiles_folding autocmd!

  " neovim
  autocmd BufRead,BufNewFile */init.vim.d/*.vim setlocal foldmethod=marker

  " zsh
  autocmd BufRead,BufNewFile */.zsh/*.d/*.zsh   setlocal foldmethod=marker
  autocmd BufRead,BufNewFile */.zsh/functions/* setlocal filetype=zsh

augroup END
