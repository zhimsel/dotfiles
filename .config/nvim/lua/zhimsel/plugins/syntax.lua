-- Syntax, completion, etc
local map = require('zhimsel.util').map

return {

  -- automated linting
  {
    -- https://github.com/benekastah/neomake
    'benekastah/neomake',
    event = "VeryLazy",
    init = function()
      vim.g.neomake_open_list = 0
      vim.g.neomake_verbose   = 0

      vim.g.neomake_python_enabled_makers = { 'flake8' }
      vim.g.neomake_ruby_enabled_makers   = { 'rubocop' }
      vim.g.neomake_sh_enabled_makers     = { 'shellcheck' }
    end,
    config = function()
      vim.cmd([[call neomake#configure#automake('rw')]])
    end
  },

  -- word completion
  {
    -- https://github.com/Shougo/deoplete.nvim
    'Shougo/deoplete.nvim',
    event = "VeryLazy",
    build = ':UpdateRemotePlugins',
    config = function()
      vim.g['deoplete#enable_at_startup'] = 1

      -- use ctrl-j and ctrl-k to navigate auto-complete suggestion list
      vim.cmd([[inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"]])
      vim.cmd([[inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"]])

      -- noremap is intentionally not used here
      vim.cmd([[imap <expr> <CR>  (pumvisible() ? "\<C-y>\<CR>" : "\<CR>")]])
    end,
  },

  -- JSON syntax/etc
  {
    -- https://github.com/elzr/vim-json
    'elzr/vim-json',
    ft = 'json',
    init = function()
      vim.g.vim_json_syntax_conceal = 0
    end,
  },

  -- Terraform syntax/etc
  {
    -- https://github.com/hashivim/vim-terraform
    'hashivim/vim-terraform',
    ft = 'terraform',
    init = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 1
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
    init = function()
      -- movement
      map('n', 'J',     'j',                                      { buffer = true })
      map('n', 'K',     'k',                                      { buffer = true })
      map('n', '<C-e>', '<Plug>(auto_git_diff_scroll_down_1)',    { buffer = true, noremap = false })
      map('n', '<C-d>', '<Plug>(auto_git_diff_scroll_down_half)', { buffer = true, noremap = false })
      map('n', '<C-y>', '<Plug>(auto_git_diff_scroll_up_1)',      { buffer = true, noremap = false })
      map('n', '<C-u>', '<Plug>(auto_git_diff_scroll_up_half)',   { buffer = true, noremap = false })

      -- commit actions
      map('n', '<leader>p', ':Pick<CR>',   { buffer = true })
      map('n', '<leader>r', ':Reword<CR>', { buffer = true })
      map('n', '<leader>e', ':Edit<CR>',   { buffer = true })
      map('n', '<leader>s', ':Squash<CR>', { buffer = true })
      map('n', '<leader>f', ':Fixup<CR>',  { buffer = true })
      map('n', '<leader>d', ':Drop<CR>',   { buffer = true })
    end,

  },

  -- Better folding for Markdown
  {
    -- https://github.com/masukomi/vim-markdown-folding
    'masukomi/vim-markdown-folding',
    ft = 'markdown',
    init = function()
      vim.g.markdown_fold_style = 'nested'
    end,
  },

  -- Better folding for YAML
  {
    -- https://github.com/pedrohdz/vim-yaml-folds
    'pedrohdz/vim-yaml-folds',
    ft = 'yaml',
  },

  -- Better folding for Python
  {
    -- https://github.com/tmhedberg/SimpylFold
    'tmhedberg/SimpylFold',
    event = "VeryLazy",
    ft = 'python',
    init = function()
      vim.g.SimpylFold_docstring_preview = 1
      vim.g.SimpylFold_fold_import = 0
    end,
  },

  -- Syntax/tools for Golang
  {
    -- https://github.com/fatih/vim-go
    'fatih/vim-go',
    ft = 'go',
    build = ':GoUpdateBinaries',
  },

}
