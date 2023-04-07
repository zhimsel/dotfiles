-- Git-related plugins
return {

  -- git diff symbols in sign column
  {
    -- https://github.com/airblade/vim-gitgutter
    'airblade/vim-gitgutter',
    init = function()
      vim.g.gitgutter_max_signs = 10000
    end
  },

  -- lots of git commands/shortcuts
  {
    -- https://github.com/tpope/vim-fugitive
    'tpope/vim-fugitive',
    action = "VeryLazy",
  },

  -- interface for Github
  {
    -- https://github.com/tpope/vim-rhubarb
    'tpope/vim-rhubarb',
    dependencies = {
      'tpope/vim-fugitive'
    },
    cmd = 'GBrowse',
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

}
