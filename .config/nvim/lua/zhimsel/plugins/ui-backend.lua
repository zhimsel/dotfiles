-- Plugins related to behind-the-scenes UI stuff
return {

  -- switch between tmux/vim panes seamlessly
  -- https://github.com/christoomey/vim-tmux-navigator
  {
    'christoomey/vim-tmux-navigator',
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      -- keymaps set in lua/zhimsel/key-maps.lua
    end,
  },

  -- save and restore view when closing file buffers
  {
    -- https://github.com/zhimsel/vim-stay
    'zhimsel/vim-stay',
    url = 'git@github.com:zhimsel/vim-stay.git',
    dev = true, pin = true,
    lazy = false,
  },

}
