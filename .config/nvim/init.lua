-- Load init files from init.vim.d directories
vim.cmd('runtime! init.vim.d/**/*.vim')
vim.cmd('runtime! init.vim.d/**/*.lua')
