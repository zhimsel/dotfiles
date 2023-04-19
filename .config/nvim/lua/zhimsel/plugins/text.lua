-- Plugins for manipulating and moving around text
local map = require('zhimsel.util').map

return {

  -- easily align text into columns
  {
    -- https://github.com/junegunn/vim-easy-align
    'junegunn/vim-easy-align',
    event = "VeryLazy",
    config = function()
      map('x', 'ga', '<Plug>(EasyAlign)', { noremap = false })
      map('n', 'ga', '<Plug>(EasyAlign)', { noremap = false })
    end,
  },

  -- improved motions with skipping objects
  {
    -- https://github.com/phaazon/hop.nvim
    'phaazon/hop.nvim',
    branch = "v2",
    event = "VeryLazy",
    config = function(_, opts)
      local hop  = require('hop')
      local hint = require('hop.hint')
      hop.setup(opts)

      -- Hop to lines
      map('', '<leader><leader>j', function() hop.hint_vertical({ direction = hint.HintDirection.AFTER_CURSOR }) end)
      map('', '<leader><leader>k', function() hop.hint_vertical({ direction = hint.HintDirection.BEFORE_CURSOR }) end)

      -- Hop to words
      map('', '<leader><leader>w', function() hop.hint_words({ direction = hint.HintDirection.AFTER_CURSOR }) end)
      map('', '<leader><leader>b', function() hop.hint_words({ direction = hint.HintDirection.BEFORE_CURSOR }) end)

      -- <C-_> is Ctrl-/
      map('',  '<C-_>', function() hop.hint_patterns() end)
      map('o', '<C-_>', function() hop.hint_patterns() end)
    end
  },

  -- improved search/replace with case-specific behavior
  {
    -- https://github.com/tpope/vim-abolish
    'tpope/vim-abolish',
    event = "VeryLazy",
  },

  -- highlight t/T/f/F targets
  {
    -- https://github.com/unblevable/quick-scope
    'unblevable/quick-scope',
    event = "VeryLazy",
    init = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end
  },

  -- manipulate function arguments
  {
    -- https://github.com/PeterRincker/vim-argumentative
    'PeterRincker/vim-argumentative',
    event = "VeryLazy",
  },

  -- comment/uncomment lines automatically
  {
    -- https://github.com/tpope/vim-commentary
    'tpope/vim-commentary',
    event = "VeryLazy",
  },

  -- automatic if/for/etc block closing
  {
    -- https://github.com/tpope/vim-endwise
    'tpope/vim-endwise',
    event = "VeryLazy",
  },

  -- improved repeats
  {
    -- https://github.com/tpope/vim-repeat
    'tpope/vim-repeat',
    event = "VeryLazy",
  },

  -- add/remove/modify surrounding brackets/quotes/etc
  {
    -- https://github.com/tpope/vim-surround
    'tpope/vim-surround',
    event = "VeryLazy",
  },

  -- sort using text objects
  {
    -- https://github.com/christoomey/vim-sort-motion
    'christoomey/vim-sort-motion',
    event = "VeryLazy",
  }

}
