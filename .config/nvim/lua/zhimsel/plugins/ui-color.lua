return {

  -- better themes
  {
    -- https://github.com/chriskempson/base16-vim
    'chriskempson/base16-vim',
    lazy = false, -- this should be loaded at startup
    priority = 999, -- and it should be loaded FIRST
    config = function()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('base16-eighties')
    end,
  },

  -- better statusbar
  {
    -- https://github.com/vim-airline/vim-airline
    'vim-airline/vim-airline',
    lazy = false,
    priority = 888, -- load after main theme
    init = function()
      vim.g['airline_theme'] = "base16_eighties_custom" -- defined in autoload/airline/themes/
      -- post-load config in lua/zhimsel/plugin-config/vim-airline.lua
    end,
  },

  -- automatically highlight color codes with their color
  -- https://github.com/chrisbra/Colorizer
  { 'chrisbra/Colorizer' },

  -- visual marker for indent level
  -- https://github.com/Yggdroot/indentLine
  {
    'Yggdroot/indentLine',
    init = function()
      vim.g.indentLine_char            = '│' -- UTF-8 font required
      vim.g.indentLine_concealcursor   = ''
      vim.g.indentLine_fileTypeExclude = { 'Help', 'man' }
      vim.g.indentLine_bufTypeExclude  = { 'terminal' }
      vim.g.indentLine_bufNameExclude  = { 'NERD_tree.*' }
    end
  },

  -- highlight unwanted whitespaces
  {
    -- https://github.com/ntpeters/vim-better-whitespace
    'ntpeters/vim-better-whitespace',
    init = function()
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 0

      -- Disable whitespace highlighting on the current line
      vim.g.current_line_whitespace_disabled_soft = 1

      -- Disable whitespace highlighting for certain filetypes
      vim.g.better_whitespace_filetypes_blacklist = {
        -- Upstream default
        'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive',
        -- Mine
        'go',
      }
    end,
  },

}
