-- Filetype detection
vim.cmd('filetype plugin indent on') -- Enable filetype plugins

-- Backend 'system' settings
vim.opt.fileformats = { 'unix', 'dos', 'mac' } -- Use Unix as the standard file type
vim.opt.guicursor = {} -- disable changing cursor shape
vim.opt.hidden = true -- A buffer becomes hidden when it is abandoned
vim.opt.history = 1000 -- Store a longer command history
vim.opt.lazyredraw = true -- Don't redraw while executing macros (good performance config)
vim.opt.redrawtime = 10000 -- Longer for large files' syntax highlighting
vim.opt.mouse = {
  a = true,
  r = true,
} -- Enable mouse interaction
vim.opt.timeoutlen = 500 -- Set timeout for completing keymaps
vim.opt.undofile = true -- Save per-file undo history between sessions
vim.opt.updatetime = 100  -- how quickly to write the swapfile after typing stops
vim.opt.viewoptions = { 'folds', 'cursor', 'curdir' } -- what to save in session files (and for vim-stay)

-- Status line
vim.opt.cmdheight = 1 -- Height of the command bar
vim.opt.showmode = false -- Disable --INSERT-- text in command line (it's reproduced in vim-airline)
vim.opt.report = 0 -- tell us about changes
vim.opt.shortmess:append({ I = true }) -- Disable welcome message
vim.opt.showcmd = true -- show (partial) command in status line

-- Sign column and line display
vim.opt.cursorline = true -- Highlight current line
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = false -- those line numbers are relative to the current line
vim.opt.numberwidth = 4  -- minimum width of the number column
vim.opt.signcolumn = "auto:1-4"  -- show sign column left of line numbers (for gitgutter, linting, etc)

-- Searching
vim.opt.hlsearch = true -- Highlight search results
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.incsearch = true -- Makes search act like search in modern browsers
vim.opt.magic = true -- For regular expressions turn magic on
vim.opt.matchpairs:append("<:>") -- Highlight extra matched pairs
vim.opt.matchtime = 2 -- How many tenths of a second to blink when matching brackets
vim.opt.showmatch = true -- Show matching brackets when text indicator is over them
vim.opt.smartcase = true -- When searching try to be smart about cases

-- Folding
vim.opt.foldenable = true
vim.opt.foldlevelstart = 999 -- Start with all folds open

-- Defaults for tab width
vim.opt.expandtab = true
vim.opt.shiftwidth = 0 -- set to 0, will use value of tabstop
vim.opt.smarttab = true
vim.opt.tabstop = 2

-- Auto-indenting/breaking
vim.opt.autoindent = true
vim.opt.colorcolumn = ({ '+1', '+21' })
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.textwidth = 0
vim.opt.whichwrap:append({
  ['<'] = true,
  ['>'] = true,
  h = true,
  l = true,
}) -- Wrap lines on movement for 'h/l' keys
vim.opt.wrap = true
vim.opt.joinspaces = false

-- Completion
vim.opt.completeopt:append({ 'noinsert', 'noselect' })
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest', 'list', 'full' }

-- Spell checking
vim.opt.spelllang = { 'en_us' }

-- Movement
vim.opt.backspace = { 'eol', 'start', 'indent' } -- Configure backspace so it acts more intuitively
vim.opt.iskeyword:append('-') -- Word separators
vim.opt.startofline = false -- don't jump to start of line when scrolling
vim.opt.scrolloff = 7 -- Set 7 lines to the cursor - when moving vertically using j/k

-- Windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set default commentstring
-- `#` is way more common that the default
vim.opt.commentstring = "# %s"

-- Use neovim-remote to avoid nested vim sessions within Terminal buffers
vim.env.EDITOR = 'nvr --nostart'
vim.env.GIT_EDITOR = 'nvr --nostart -cc split --remote-wait'

-- disable netrw, nvim-tree.lua takes over 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
