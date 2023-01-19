augroup filetype_go autocmd!

  autocmd FileType go setlocal
        \ noexpandtab

  " Use Omni completion for Golang
  autocmd FileType go call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

augroup END
