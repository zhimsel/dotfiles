local map = require('zhimsel.util').map

-- Set leader key to <space>
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Colors/visual/etc

-- Disable search highlight when <Esc><Esc> is pressed
map('n', [[<Esc><Esc>]], [[:noh<CR>]])

-- Redraw the screen
map('n', '<leader>r', '<cmd>redraw!<CR>', { silent = false })

-------- Buffers, windows, and tabs --------

-- Switch windows more easily (using vim-tmux-navigator)
map({ 'n', 't' }, [[<M-h>]], [[<cmd>TmuxNavigateLeft<CR>]])
map({ 'n', 't' }, [[<M-j>]], [[<cmd>TmuxNavigateDown<CR>]])
map({ 'n', 't' }, [[<M-k>]], [[<cmd>TmuxNavigateUp<CR>]])
map({ 'n', 't' }, [[<M-l>]], [[<cmd>TmuxNavigateRight<CR>]])

-- Open new windows
map({ 'n', 't' }, [[<C-w>-]], [[<cmd>sp<CR>]])
map({ 'n', 't' }, [[<C-w>\]], [[<cmd>vsp<CR>]])

-- Zoom window
map({ 'n', 't' }, [[<C-w>+]], [[<cmd>vertical resize | resize<CR>]])

-- Create and switch to tabs more easily
map({ 'n', 't' }, [[<C-w>t]],     [[<cmd>tabnew<CR>]])
map({ 'n', 't' }, [[<C-w>T]],     [[<cmd>tab split<CR>]])
map({ 'n', 't' }, [[<C-w>tc]],    [[<cmd>tabclose<CR>]])
map({ 'n', 't' }, [[<C-w><C-t>]], [[<cmd>Telescope telescope-tabs list_tabs<CR>]])

-- Switch the CWD to the directory of the open buffer
map('n', [[<leader>cd]], [[:lcd %:p:h<CR>:pwd<CR>]])

-- Do some "normal" window things in terminal windows
map('t', [[<C-w>c]],     [[<cmd>close<CR>]])
map('t', [[<C-w><Esc>]], [[<C-\><C-n>]]) -- Remap terminal exit

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

-- format text using the lsp
map('n', '<leader>f', vim.lsp.buf.format)
map('v', '<leader>f', function()
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    }
  })
end
)

-- Unmap the default CTRL-S (so it can be used by vim-surround)
vim.keymap.del('i', '<c-s>')


-------- Motion --------

-- In visual mode, move to first/last line of paragraph (useful for visual block)
map('v', '[', [[:<C-U>call cursor(line("'{")-1,col("'>"))<CR>`<1v``]])
map('v', ']', [[:<C-U>call cursor(line("'}")-1,col("'>"))<CR>`<1v``]])

-- Select recently-pasted text
map('n', 'gp', '`[v`]')


-------- Jumping --------

-- Remap Ctrl-i/o jump maps
-- (they are used for nvim-tree; plus I find the remaps more intuitive)
map('n', '[j', [[<C-o>]])
map('n', ']j', [[<C-i>]])


map('n', '[l',          [[<Plug>LocationPrevious]], { noremap = false })
map('n', ']l',          [[<Plug>LocationNext]],     { noremap = false })
map('n', [[<leader>l]], [[:lopen<CR>]])

map('n', [[<leader>q]], [[:copen<CR>]])
