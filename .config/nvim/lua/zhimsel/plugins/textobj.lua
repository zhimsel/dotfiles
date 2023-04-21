-- Plugins that provide custom text objects
return {

  -- required by any vim-textobj-* plugins
  { 'kana/vim-textobj-user' },

  -- use comments as text objects
  {
    'glts/vim-textobj-comment',
    dependencies = { 'kana/vim-textobj-user' },
  },

  -- use folds as text objects
  {
    'kana/vim-textobj-fold',
    dependencies = { 'kana/vim-textobj-user' },
  },

  -- use paragraph-at-indent as textobjects
  {
    'pianohacker/vim-textobj-indented-paragraph',
    dependencies = { 'kana/vim-textobj-user' },
  },

  -- use indent levels as text objects
  -- https://github.com/michaeljsmith/vim-indent-object
  { 'michaeljsmith/vim-indent-object' },

  -- additional text objects
  -- https://github.com/wellle/targets.vim
  { 'wellle/targets.vim' },

  -- Use Treesitter nodes as textobjects
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {

          -- Selection objects (like `ip` or `ap` for in/around paragraph)
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
              ['ib'] = '@block.inner',
              ['ab'] = '@block.outer',
              ['if'] = '@function.inner',
              ['af'] = '@function.outer',
              ['iF'] = '@class.inner',
              ['aF'] = '@class.outer',
              ['aS'] = '@statement.outer',
              ['iC'] = '@conditional.inner',
              ['aC'] = '@conditional.outer',
              ['il'] = '@loop.inner',
              ['al'] = '@loop.outer',
            },
            include_surrounding_whitespace = true,
          },

          -- Movements
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']f'] = '@function.outer',
              [']F'] = '@class.outer',
              [']b'] = '@block.outer',
              --
            },
            goto_next_end = {
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[F'] = '@class.outer',
              ['[b'] = '@block.outer',
            },
            goto_previous_end = {
            },
            goto_next = {
            },
            goto_previous = {
            }
          },
        },
      })


      -- Repeat movement with ; and ,
      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    end
  },

}
