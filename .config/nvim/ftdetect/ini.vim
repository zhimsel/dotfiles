autocmd BufRead,BufNewFile ~/.aws/{config,credentials}  set filetype=ini
autocmd BufRead,BufNewFile $AWS_CONFIG_FILE             set filetype=ini
autocmd BufRead,BufNewFile $AWS_SHARED_CREDENTIALS_FILE set filetype=ini
