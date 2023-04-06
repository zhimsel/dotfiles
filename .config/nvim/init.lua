require('zhimsel.options')

-- LEGACY: Load init files from init.vim.d directories
vim.cmd('runtime! init.vim.d/**/*.vim')
vim.cmd('runtime! init.vim.d/**/*.lua')

-- For now, this must come after the above legacy files
-- (specifically, it must come after the colorscheme is loaded (by vim-plug/packer)
require('zhimsel.visual')

-- Enable syntax highlighting, in case it was disabled (should always be last)
vim.cmd('syntax enable')
