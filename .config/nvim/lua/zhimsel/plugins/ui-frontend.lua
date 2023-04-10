-- Plugins related to "frontend" UI stuff
local map = require('zhimsel.util').map

return {

  -- file/directory explorer
  {
    -- https://github.com/preservim/nerdtree
    'preservim/nerdtree',
    event = "VeryLazy",
    init = function()
      -- internal maps
      vim.g.NERDTreeMapPreview       = 'O'
      vim.g.NERDTreeMapOpenSplit     = 's'
      vim.g.NERDTreeMapPreviewSplit  = 'S'
      vim.g.NERDTreeMapOpenVSplit    = 'v'
      vim.g.NERDTreeMapPreviewVSplit = 'V'

      -- options
      vim.g.NERDTreeHighlightCursorline = 1
      vim.g.NERDTreeHijackNetrw         = 1
      vim.g.NERDTreeMinimalMenu         = 1
      vim.g.NERDTreeMinimalUI           = 1
      vim.g.NERDTreeMouseMode           = 1
      vim.g.NERDTreeQuitOnOpen          = 0
      vim.g.NERDTreeShowHidden          = 1
      vim.g.NERDTreeWinSize             = 31

      -- Always open files in current window
      -- (don't switch to it if it's already open)
      vim.g.NERDTreeCustomOpenArgs = {
        dir = {},
        file = { keepopen = 1, reuse = "", where = "p" }
      }
    end,
    config = function()
      map('n', '<Tab>',   ':NERDTreeMirror<CR>:NERDTreeFocus<CR>')
      map('n', '<S-Tab>', ':NERDTreeToggle<CR>')
      map('n', '<C-o>',   ':NERDTreeFind<CR>')
    end,
  },

  -- show git status symbols in NERDTree
  {
    -- https://github.com/Xuyuanp/nerdtree-git-plugin
    'Xuyuanp/nerdtree-git-plugin',
    dependencies = {
      'preservim/nerdtree',
    }
  },

  -- interactive buffer management
  -- https://github.com/jlanzarotta/bufexplorer
  {
    'jlanzarotta/bufexplorer',
    init = function()
      vim.g.bufExplorerDisableDefaultKeyMapping = 1
      vim.g.bufExplorerFindActive               = 0
      map('n', '<leader>b', '<cmd>ToggleBufExplorer<CR>')
    end,
    cmd = {
      "BufExplorer",
      "ToggleBufExplorer",
      "BufExplorerHorizontalSplit",
      "BufExplorerVerticalSplit",
    }
  },

  -- fuzzy-finding all sorts of things (files, buffers, lines, etc)
  {
    -- https://github.com/junegunn/fzf.vim
    'junegunn/fzf.vim',
    dependencies = {
      { 'junegunn/fzf' }
    },
    init = function()
      vim.g.fzf_layout = {
        window = {
          width = 0.9,
          height = 0.8,
        }
      }
      vim.g.fzf_action = {
        ['ctrl-t'] = 'tab split',
        ['ctrl-s'] = 'split',
        ['ctrl-v'] = 'vsplit',
      }
    end,
    config = function()
      map('n', '<c-t>', ':Files<CR>')
      map('n', '<c-f>', ':BLines<CR>')
      map('n', '<c-g>', ':GitFiles<CR>')
      map('n', '<c-b>', ':Buffers<CR>')
      map('n', '```',   ':Marks<CR>')
    end,
  },

  -- visual selection of entire undo tree for a file
  {
    -- https://github.com/mbbill/undotree
    'mbbill/undotree',
    keys = {
      {
        '<leader>u', ':UndotreeShow<CR>:UndotreeFocus<CR>',
        mode = 'n', noremap = true, silent = true,
      },
    },
  },

  -- preview registers before using them
  -- https://github.com/junegunn/vim-peekaboo
  {
    'junegunn/vim-peekaboo',
    event = "VeryLazy",
    init = function()
      vim.g.peekaboo_window = 'bel new'
      vim.g.peekaboo_delay = 300 -- (in milliseconds)
    end,
  },


  -- move windows around more easily
  -- https://github.com/yaronkh/vim-winmanip
  {
    'yaronkh/vim-winmanip',
    keys = {
      {
        '<C-w><C-h>', '<Plug>(MoveJumpBufLeft)',
        mode = 'n', noremap = false, silent = true,
      },
      {
        '<C-w><C-j>', '<Plug>(MoveJumpBufDown)',
        mode = 'n', noremap = false, silent = true,
      },
      {
        '<C-w><C-k>', '<Plug>(MoveJumpBufUp)',
        mode = 'n', noremap = false, silent = true,
      },
      {
        '<C-w><C-l>', '<Plug>(MoveJumpBufRight)',
        mode = 'n', noremap = false, silent = true,
      },
    },
    init = function()
      vim.g.winmanip_disable_key_mapping = 1
    end
  },

  -- swap two panes easily
  -- https://github.com/wesQ3/vim-windowswap
  { 'wesQ3/vim-windowswap' },

}