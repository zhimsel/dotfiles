-- Syntax, completion, etc
local map = require('zhimsel.util').map

return {

  -- LSP
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',

    dependencies = {
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'FelipeLema/cmp-async-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-emoji' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip' },
    },

  },

  -- Highlighting, folding, indenting
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(vim.cmd, ':TSUpdate')
    end,
    config = function()
      require 'nvim-treesitter.configs'.setup {
        sync_install = false,
        auto_install = true,

        ensure_installed = {
          'comment',
          'diff',
          'query',
          'vim', 'vimdoc',
        },
        ignore_install = {},

        highlight = {
          enable = true,
          disable = {},
        },

        indent = {
          enable = true,
        },

      }

      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
    end
  },

  {
    'nvim-treesitter/playground',
    event = "VeryLazy",
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
  },

  -- Terraform: format on save, etc
  {
    -- https://github.com/hashivim/vim-terraform
    'hashivim/vim-terraform',
    ft = 'terraform',
    init = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 1
    end,
  },

}
