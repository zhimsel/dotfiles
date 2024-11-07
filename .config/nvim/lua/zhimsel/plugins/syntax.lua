-- Syntax, completion, etc
return {

  -- LSP/completion
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',

    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },

      -- Sources for nvim-cmp
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-emoji' },
      { 'tzachar/cmp-fuzzy-buffer', dependencies = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' }, },
      { 'FelipeLema/cmp-async-path' },
      { 'petertriho/cmp-git', dependencies = { 'nvim-lua/plenary.nvim' }, },
      { 'saadparwaiz1/cmp_luasnip', dependencies = { 'L3MON4D3/LuaSnip' }, },
      { 'hrsh7th/cmp-cmdline' },
      { 'dmitmel/cmp-cmdline-history' },
      { 'f3fora/cmp-spell' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },

      -- null-ls
      {
        'nvimtools/none-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },

      -- https://github.com/b0o/SchemaStore.nvim
      { "b0o/schemastore.nvim" },
    },
  },

  -- Highlighting, folding, indenting
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      vim.cmd(':TSUpdate')
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

}
