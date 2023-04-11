local map = require('zhimsel.util').map
local builtin = require('telescope.builtin')

-- mappings to be set in both Insert and Normal mode
local telescope_mappings_i_n = {
  -- ctrl-j/k to go down/up
  ['<C-j>'] = 'move_selection_next',
  ['<C-k>'] = 'move_selection_previous',

  -- make horizontal split more intuitive
  ['<C-s>'] = 'select_horizontal',
}

require('telescope').setup({
  defaults = {
    mappings = {
      i = vim.tbl_deep_extend('force', telescope_mappings_i_n, {
        -- Use <C-f> instead of <Esc> to get into normal mode (similar to Ex mode)
        -- ['<Esc>'] = 'close', TODO
      }),
      n = telescope_mappings_i_n,
    },

    -- layout
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      prompt_position = 'top',
      height = 0.9,
      width = 0.9,
    },
    path_display = 'smart',
  },

  pickers = {
    buffers = {
      sort_lastused = true,
    },
  },
})

-- Load extensions (after telescope has been configured)
require('telescope').load_extension('fzf')
require('telescope').load_extension('lazy')
require('telescope').load_extension('telescope-tabs')
require('telescope').load_extension('terraform_doc')
require('telescope').load_extension('undo')

-- Set up some command shortcuts
vim.cmd([[
  cabbrev T Telescope
]])

-- Finding files
map('n', '<C-t>',      builtin.find_files)
map('n', '<C-g>',      builtin.git_files)
map('n', '<Leader-g>', builtin.live_grep)
map('v', '<Leader-g>', builtin.grep_string)

-- Finding things that are open
map('n', '<C-f>', builtin.current_buffer_fuzzy_find)
map('n', '<C-b>', builtin.buffers)
map('n', '<C-j>', builtin.jumplist)
map('n', '<C-q>', builtin.quickfix)
map('n', '<C-l>', builtin.loclist)
map('n', '```',   builtin.marks)
