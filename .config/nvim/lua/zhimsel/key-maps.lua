local map = require('zhimsel.util').map

-- Set leader key to <space>
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable search highlight when <Esc><Esc> is pressed
map('n', [[<Esc><Esc>]], [[:noh<CR>]])


-------- Buffers, windows, and tabs --------

-- Switch windows more easily
map('n', [[<M-h>]], [[:TmuxNavigateLeft<CR>]])
map('n', [[<M-j>]], [[:TmuxNavigateDown<CR>]])
map('n', [[<M-k>]], [[:TmuxNavigateUp<CR>]])
map('n', [[<M-l>]], [[:TmuxNavigateRight<CR>]])

-- Open new windows
map('n', [[<C-w>-]], [[:sp<CR>]])
map('n', [[<C-w>\]], [[:vsp<CR>]])

-- Zoom window
map('n', [[<C-w>+]], [[<C-w>|<C-w>_]])

-- Create and switch to tabs more easily
map('n', [[<C-w>t]],  [[:tabnew<CR>]])
map('n', [[<C-w>T]],  [[:tab split<CR>]])
map('n', [[<C-w>tc]], [[:tabclose<CR>]])

-- Switch the CWD to the directory of the open buffer
map('n', [[<leader>cd]], [[:lcd %:p:h<CR>:pwd<CR>]])

-- Remap terminal exit
map('t', [[<C-w><Esc>]], [[<C-\><C-n>]])

-- Open split terminal in current directory (or current file's directory)
map('n', [[<leader>t]], [[:split | terminal<CR>]])
map('n', [[<leader>T]], [[:split | lcd %:p:h | terminal<CR>]])


-------- Folding --------

-- Middle-click mouse to open/close folds
map('n', [[<MiddleMouse>]], [[<LeftMouse>za]])

-- Make parent fold moves more intuitive
map('n', 'zK', '[z')
map('n', 'zJ', ']z')


-------- Registers --------

-- Send most-recently-yanked register to system clipboard
map('n', [[<leader>y]], [[:let @+=@"<CR>]], { silent = false })
map('n', [[<leader>Y]], [[:%y +<CR>]])


-------- Manipulating text  --------

-- Toggle 'paste'
map('n', [[<leader>p]], [[:set paste!<CR>]])

-- Move lines up/down
map('n', [[<Down>]], [[:m+<CR>==]])
map('v', [[<Down>]], [[:m '>+1<CR>gv=gv]])
map('n', [[<Up>]],   [[:m-2<CR>==]])
map('v', [[<Up>]],   [[:m '<-2<CR>gv=gv]])

-- Move selected text left/right
map('n', '<Right>', 'xp`[v`]')
map('v', '<Right>', 'xp`[v`]')
map('n', '<Left> ', 'xhhp`[v`]')
map('v', '<Left> ', 'xhhp`[v`]')

-- Keep cursor position when joining lines
map('n', [[J]], [[m`J``]])


-------- Motion --------

-- In visual mode, move to first/last line of paragraph (useful for visual block)
map('v', '[', [[:<C-U>call cursor(line("'{")-1,col("'>"))<CR>`<1v``]])
map('v', ']', [[:<C-U>call cursor(line("'}")-1,col("'>"))<CR>`<1v``]])

-- Select recently-pasted text
map('n', 'gp', '`[v`]')


-------- Jumping --------

-- Remap Ctrl-i/o jump maps (Used for NERDtree)
map('n', '[j', [[<C-o>]])
map('n', ']j', [[<C-i>]])


map('n', '[l',          [[<Plug>LocationPrevious]], { noremap = false })
map('n', ']l',          [[<Plug>LocationNext]],     { noremap = false })
map('n', [[<leader>l]], [[:lopen<CR>]])


-------- Git --------

map('n', '<leader>ha', [[<Plug>(GitGutterStageHunk)]],   { noremap = false })
map('n', '<leader>hp', [[<Plug>(GitGutterPreviewHunk)]], { noremap = false })
map('n', '<leader>hr', [[<Plug>(GitGutterUndoHunk)]],    { noremap = false })
