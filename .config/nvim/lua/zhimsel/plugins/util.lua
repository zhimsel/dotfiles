-- Various plugins that provide simple or specific utilities
return {

  -- toggle checkboxes in lists
  {
    -- https://github.com/zhimsel/vim-checkbox/tree/change-map
    -- use my fork, until https://github.com/jkramer/vim-checkbox/pull/9 is merged
    'zhimsel/vim-checkbox',
    branch =  'change-map',
    keys = {
      {
        '<leader>x', ':call checkbox#ToggleCB()<CR>',
        mode = 'n', noremap = true, silent = true,
      },
    },
    init = function()
      vim.g.insert_checkbox_prefix = '- '
      vim.g.checkbox_create_maps = 0
    end
  },

  -- batch-rename files in vim
  {
    -- https://github.com/qpkorr/vim-renamer
    'qpkorr/vim-renamer',
    cmd = 'Renamer',
  },

  -- open URLs in browser
  -- https://github.com/tyru/open-browser.vim
  {
    'tyru/open-browser.vim',
    keys = {
      {
        '<leader>o', '<Plug>(openbrowser-smart-search)',
        mode = 'v', noremap = false
      }
    }
  },

  -- Open a rendered preview of a Markdown file in the browser
  -- https://github.com/iamcco/markdown-preview.nvim
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = {
      {
        '<leader>gp', '<Plug>MarkdownPreviewToggle',
        mode = 'n', noremap = false
      }
    }
  },

  -- useful shell commands
  -- https://github.com/tpope/vim-eunuch
  {
    'tpope/vim-eunuch',
    config = function()
      -- Read/write buffer with root permissions
      vim.api.nvim_create_user_command('WW', 'SudoWrite', { bang = true })
      vim.api.nvim_create_user_command('EE', 'SudoEdit',  { bang = true })
    end
  },

}
