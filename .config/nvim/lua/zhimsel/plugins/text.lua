-- Plugins for manipulating and moving around text
local map = require('zhimsel.util').map

return {

  -- easily align text into columns
  {
    -- https://github.com/junegunn/vim-easy-align
    'junegunn/vim-easy-align',
    action = "VeryLazy",
    init = function()
      map('x', 'ga', '<Plug>(EasyAlign)', { noremap = false })
      map('n', 'ga', '<Plug>(EasyAlign)', { noremap = false })
    end,
  },

  -- improved motions with skipping objects
  {
    -- https://github.com/Lokaltog/vim-easymotion
    'Lokaltog/vim-easymotion',
    action = "VeryLazy",
    init = function()
      -- keep cursor colum when JK motion
      vim.g.EasyMotion_startofline = 0

      map('', '<leader><leader>l', '<Plug>(easymotion-lineforward)')
      map('', '<leader><leader>j', '<Plug>(easymotion-j)')
      map('', '<leader><leader>k', '<Plug>(easymotion-k)')
      map('', '<leader><leader>h', '<Plug>(easymotion-linebackward)')

      -- <C-_> is Ctrl-/
      map('', '<C-_>', '<Plug>(easymotion-sn)')
      map('o', '<C-_>', '<Plug>(easymotion-tn)')
    end
  },

  -- improved search/replace with case-specific behavior
  {
    -- https://github.com/tpope/vim-abolish
    'tpope/vim-abolish',
    action = "VeryLazy",
  },

  -- highlight t/T/f/F targets
  {
    -- https://github.com/unblevable/quick-scope
    'unblevable/quick-scope',
    action = "VeryLazy",
    init = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end
  },

  -- manipulate function arguments
  {
    -- https://github.com/PeterRincker/vim-argumentative
    'PeterRincker/vim-argumentative',
    action = "VeryLazy",
  },

  -- comment/uncomment lines automatically
  {
    -- https://github.com/tpope/vim-commentary
    'tpope/vim-commentary',
    action = "VeryLazy",
  },

  -- automatic if/for/etc block closing
  {
    -- https://github.com/tpope/vim-endwise
    'tpope/vim-endwise',
    action = "VeryLazy",
  },

  -- improved repeats
  {
    -- https://github.com/tpope/vim-repeat
    'tpope/vim-repeat',
    action = "VeryLazy",
  },

  -- add/remove/modify surrounding brackets/quotes/etc
  {
    -- https://github.com/tpope/vim-surround
    'tpope/vim-surround',
    action = "VeryLazy",
  },

}
