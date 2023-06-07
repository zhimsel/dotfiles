-- Plugins related to "frontend" UI stuff
local map = require('zhimsel.util').map

return {

  -- file/directory explorer
  {
    -- https://github.com/nvim-tree/nvim-tree.lua
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    config = function()

      -- In-window mappings
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '<Tab>', function() vim.cmd('wincmd p') end,          opts('Previous window'))
        vim.keymap.set('n', 'C',     api.tree.change_root_to_node,                opts('CD'))
        vim.keymap.set('n', 't',     api.node.open.tab,                           opts('Open: New Tab'))
        vim.keymap.set('n', 'v',     api.node.open.vertical,                      opts('Open: Vertical Split'))
        vim.keymap.set('n', 's',     api.node.open.horizontal,                    opts('Open: Horizontal Split'))
        vim.keymap.set('n', 'z',     function() vim.cmd('NvimTreeResize 90') end, opts('Zoom'))
        vim.keymap.set('n', 'Z',     function() vim.cmd('NvimTreeResize 30') end, opts('Unzoom'))
      end

      -- Config settings
      require("nvim-tree").setup({
        on_attach = on_attach,
        git = {
          ignore = false,
        },
        modified = {
          enable = true,
        },
        view = {
          width = 30,
        },
        renderer = {
          indent_width = 1,
          add_trailing = true,
          icons = {
            show = {
              file = false,
              folder = false,
            },
            glyphs = {
              folder = {
                arrow_closed = "⏵",
                arrow_open = "⏷",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "⌥",
                renamed = "➜",
                untracked = "★",
                deleted = "⊖",
                ignored = "◌",
              },
            },
          },
        },
      })

      -- Out-of-window mappings
      map('n', '<Tab>',   ':NvimTreeFocus<CR>')
      map('n', '<S-Tab>', ':NvimTreeToggle<CR>')
      map('n', '<C-o>',   ':NvimTreeFindFile<CR>')
    end,
  },

  -- show the context of your current text using treesitter
  -- https://github.com/nvim-treesitter/nvim-treesitter-context,
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
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

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'tsakirist/telescope-lazy.nvim',
      'ANGkeith/telescope-terraform-doc.nvim',
      'LukasPietzschmann/telescope-tabs',
      'debugloop/telescope-undo.nvim',
    },
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
