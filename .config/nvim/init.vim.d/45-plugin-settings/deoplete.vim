let g:deoplete#enable_at_startup = 1

" use ctrl-j and ctrl-k to navigate auto-complete suggestion list
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" noremap is intentionally not used here
imap <expr> <CR>  (pumvisible() ? "\<C-y>\<CR>" : "\<CR>")
