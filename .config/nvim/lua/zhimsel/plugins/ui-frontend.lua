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

        -- "meta"
        vim.keymap.set('n', '<Tab>',         api.tree.close,                     opts('Close'))
        vim.keymap.set('n', '<Esc>',         api.tree.close,                     opts('Close'))
        vim.keymap.set('n', 'q',             api.tree.close,                     opts('Close'))
        vim.keymap.set('n', 'R',             api.tree.reload,                    opts('Refresh'))
        vim.keymap.set('n', 'g?',            api.tree.toggle_help,               opts('Help'))

        -- navigation
        vim.keymap.set('n', 'C',             api.tree.change_root_to_node,       opts('CD to selected'))
        vim.keymap.set('n', 'U',             api.tree.change_root_to_parent,     opts('CD up'))
        vim.keymap.set('n', '<BS>',          api.node.navigate.parent_close,     opts('Close Directory'))
        vim.keymap.set('n', '<C-p>',         api.node.navigate.parent,           opts('Parent Directory'))
        vim.keymap.set('n', '<C-j>',         api.node.navigate.sibling.next,     opts('Next Sibling'))
        vim.keymap.set('n', '<C-k>',         api.node.navigate.sibling.prev,     opts('Previous Sibling'))
        vim.keymap.set('n', '[c',            api.node.navigate.git.prev,         opts('Prev Git change'))
        vim.keymap.set('n', ']c',            api.node.navigate.git.next,         opts('Next Git change'))
        vim.keymap.set('n', ']d',            api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
        vim.keymap.set('n', '[d',            api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))

        -- opening
        vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit,                 opts('Open'))
        vim.keymap.set('n', '<CR>',          api.node.open.edit,                 opts('Open'))
        vim.keymap.set('n', 't',             api.node.open.tab,                  opts('Open: New Tab'))
        vim.keymap.set('n', 'v',             api.node.open.vertical,             opts('Open: Vertical Split'))
        vim.keymap.set('n', 's',             api.node.open.horizontal,           opts('Open: Horizontal Split'))
        vim.keymap.set('n', 'O',             api.tree.expand_all,                opts('Expand directory (recursively)'))
        vim.keymap.set('n', 'E',             api.tree.expand_all,                opts('Expand directory (recursively)'))
        vim.keymap.set('n', 'W',             api.tree.collapse_all,              opts('Collapse (recursively)'))

        -- editing
        vim.keymap.set('n', 'i',             api.fs.create,                      opts('Create'))
        vim.keymap.set('n', 'y',             api.fs.copy.node,                   opts('Copy'))
        vim.keymap.set('n', 'x',             api.fs.cut,                         opts('Cut'))
        vim.keymap.set('n', 'p',             api.fs.paste,                       opts('Paste'))
        vim.keymap.set('n', 'r',             api.fs.rename,                      opts('Rename'))
        vim.keymap.set('n', '<C-r>',         api.fs.rename_sub,                  opts('Rename (full path)'))
        vim.keymap.set('n', 'm',             api.marks.toggle,                   opts('Mark file'))
        vim.keymap.set('n', 'M',             api.marks.bulk.move,                opts('Bulk move marked files'))
        vim.keymap.set('n', 'd',             api.fs.remove,                      opts('Delete'))

        -- filters
        vim.keymap.set('n', 'f',             api.live_filter.start,              opts('Filter'))
        vim.keymap.set('n', 'F',             api.live_filter.clear,              opts('Clear filter'))
        vim.keymap.set('n', 'B',             api.tree.toggle_no_buffer_filter,   opts('Only show opened'))
        vim.keymap.set('n', 'I',             api.tree.toggle_gitignore_filter,   opts('Hide gitignored files'))
        vim.keymap.set('n', 'H',             api.tree.toggle_hidden_filter,      opts('Hide hidden files'))

        -- misc
        vim.keymap.set('n', 'Y',             api.fs.copy.filename,               opts('Copy Name'))
        vim.keymap.set('n', 'gy',            api.fs.copy.relative_path,          opts('Copy Relative Path'))
        vim.keymap.set('n', 'gY',            api.fs.copy.absolute_path,          opts('Copy Absolute Path'))
        vim.keymap.set('n', 'K',             api.node.show_info_popup,           opts('Info'))


      end

      -- Config settings
      require("nvim-tree").setup({
        on_attach = on_attach,
        actions = {
          open_file = {
            window_picker = {
              enable = false
            },
          },
        },
        git = {
          ignore = false,
          show_on_open_dirs = false,
        },
        modified = {
          enable = true,
          show_on_open_dirs = false,
        },
        update_focused_file = {
          enable = true,
        },
        hijack_cursor = true,
        view = {
          width = {
            min = 30,
            max = 80,
            padding = 1,
          },
          float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = function()
              local lines = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_h = (lines - 4) -- full height (within the window)
              return {
                relative = "editor",
                border = "rounded",
                height = window_h,
                width = 30,
                row = 1,
                col = 1,
              }
            end
          }
        },
        renderer = {
          indent_width = 1,
          add_trailing = true,
          icons = {
            show = {
              file = false,
              folder = false,
            },
            modified_placement = 'before',
            git_placement = 'after',
            glyphs = {
              default = "",
              modified = "!",
              symlink = "",
              folder = {
                default = "",
                arrow_closed = "⏵",
                arrow_open = "⏷",
                open = "",
                empty = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "+",
                staged = "✓",
                unmerged = "⌥",
                renamed = "➜",
                untracked = "?",
                deleted = "✗",
                ignored = "◌",
              },
            },
          },
          special_files = {},
        },
      })

      -- Out-of-window mappings
      map('n', '<Tab>',   ':NvimTreeFocus<CR>')
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
