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

  -- markdown objects
  {
    'coachshea/vim-textobj-markdown',
    dependencies = { 'kana/vim-textobj-user' },
    ft = 'markdown',
  },

  -- ruby objects
  {
    'rhysd/vim-textobj-ruby',
    dependencies = { 'kana/vim-textobj-user' },
    ft = 'ruby',
    init = function()
      vim.g.textobj_ruby_more_mappings = 1
    end,
  },

  -- use indent levels as text objects
  -- https://github.com/michaeljsmith/vim-indent-object
  { 'michaeljsmith/vim-indent-object' },

  -- additional text objects
  -- https://github.com/wellle/targets.vim
  { 'wellle/targets.vim' },

}
