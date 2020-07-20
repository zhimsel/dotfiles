augroup filetype_dotfiles autocmd!

  " neovim
  autocmd BufRead,BufNewFile */init.vim.d/*.vim setlocal foldmethod=marker

  " zsh
  autocmd BufRead,BufNewFile */zsh/*.d/*.zsh   setlocal foldmethod=marker
  autocmd BufRead,BufNewFile */zsh/functions/* setlocal filetype=zsh

augroup END
