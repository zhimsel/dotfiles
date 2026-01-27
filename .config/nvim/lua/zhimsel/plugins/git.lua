local map = require('zhimsel.util').map

-- Git-related plugins
return {

  -- git diff symbols in sign column
  {
    -- https://github.com/airblade/vim-gitgutter
    'airblade/vim-gitgutter',
    init = function()
      vim.g.gitgutter_max_signs = 10000
    end,
    config = function()
      map('n', '<leader>ha', [[<Plug>(GitGutterStageHunk)]],   { noremap = false })
      map('v', '<leader>ha', [[<Plug>(GitGutterStageHunk)]],   { noremap = false })
      map('n', '<leader>hp', [[<Plug>(GitGutterPreviewHunk)]], { noremap = false })
      map('n', '<leader>hr', [[<Plug>(GitGutterUndoHunk)]],    { noremap = false })
    end
  },

  -- lots of git commands/shortcuts
  {
    -- https://github.com/tpope/vim-fugitive
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
      map('n', '<leader>ga', '<cmd>Git add -f %<CR>', { silent = false })
    end
  },

  -- interface for Github
  {
    -- https://github.com/tpope/vim-rhubarb
    'tpope/vim-rhubarb',
    dependencies = {
      'tpope/vim-fugitive'
    },
    event = "VeryLazy",
  },

  -- Syntax/etc for git files (commit messages, etc)
  {
    -- https://github.com/tpope/vim-git
    'tpope/vim-git',
    ft = {
      'git',
      'gitcommit',
      'gitconfig',
      'gitrebase',
      'gitsendemail',
    }
  },

  -- save current buffer/selection as a Github gist
  {
    -- https://github.com/mattn/gist-vim
    'mattn/gist-vim',
    dependencies = {
      { 'mattn/webapi-vim' }
    },
    cmd = 'Gist',
    init = function()
      vim.g.gist_detect_filetype = 1
      vim.g.gist_open_browser_after_post = 1
      vim.g.gist_clip_command = 'yank'
    end,
  },

  -- show commit diff for interactive rebases
  {
    -- https://github.com/hotwatermorning/auto-git-diff
    'hotwatermorning/auto-git-diff',
    ft = { 'gitrebase' },
    init = function()
      vim.g.auto_git_diff_show_window_at_right = 1
    end,
  },

}
