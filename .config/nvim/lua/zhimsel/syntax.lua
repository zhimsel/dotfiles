-- Set up syntax-related things separate from lazy.nvim
local map = require('zhimsel.util').map

-- Set up Mason (LSP/formatter manager)
-- Must be done before lsp-zero is called

require('mason').setup({
  ui = {
    border = 'rounded'
  }
})


-- Set up LSP

vim.lsp.set_log_level('off')

local lsp = require('lsp-zero')

lsp.preset({
  name = 'recommended',
  float_border = 'rounded',
  manage_nvim_cmp = {
    set_sources          = false, -- manually configured below
    set_basic_mappings   = false, -- manually configured below
    set_extra_mappings   = true,
    use_luasnip          = true,
    set_format           = false, -- manually configured below
    documentation_window = true,
  }
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    omit = {
      'go', -- remapped to 'gt' below
    }
  })

  -- use telescope.nvim
  map('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = true })
  map('n', 'gD', '<cmd>Telescope lsp_declarations<cr>', { buffer = true })
  map('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { buffer = true })
  map('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = true })
  map('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', { buffer = true })

  -- open a list of all warnings/errors/etc
  map('n', 'gL', '<cmd>Telescope diagnostics<cr>', { buffer = true })

  -- rename all references to symbol under the cursor
  map({ 'n', 'v' }, 'gR', '', { callback = function() vim.lsp.buf.rename() end, buffer = true })
end)

-- Disable signcolumn labels for LSP hints
lsp.set_sign_icons({
  error = '',
  warn  = '',
  hint  = '',
  info  = ''
})

require('mason-lspconfig').setup({
  automatic_installation = true
})

require('mason-lspconfig').setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,

  --  Configure the lua LS with some neovim-specific settings
  --  https://github.com/VonHeikemen/lsp-zero.nvim/blob/eb278c30b6c50e99fdfde52f7da0e0ff8d17c07e/lua/lsp-zero/server.lua#L214-L238
  ['lua_ls'] = function()
    require('lspconfig').lua_ls.setup(require('lsp-zero').nvim_lua_ls())
  end,

  -- Configure yaml LS
  ['yamlls'] = function()
    require('lspconfig').yamlls.setup({
      settings = {
        yaml = {
          format = {
            enable = true
          },
          completion = true,
          validate = true,
          editor = {
            formatOnType = true,
          },
          keyOrdering = false,
        }
      }
    })
  end

})

-- Add border around lspconfig floating windows
require('lspconfig.ui.windows').default_options.border = 'rounded'

lsp.setup()

-- Set up null-ls
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.formatting.terrafmt,
  }
})


-- Set up completion

local cmp = require('cmp')
local compare = require('cmp.config.compare')

-- Set up cmp
cmp.setup({
  -- Order and grouping matters here!
  -- This is how they will be sorted and grouped in the completion popup.
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'async_path' },
    { name = 'git' },
    { name = 'copilot' },
    { -- all buffers
      name = 'fuzzy_buffer',
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
            if buftype ~= 'nofile' and buftype ~= 'prompt' then
              bufs[#bufs + 1] = buf
            end
          end
          return bufs
        end
      },
    },
    {
      name = 'spell',
      enable_in_context = function() -- only enable when on a misspelled word
        return require('cmp.config.context').in_treesitter_capture('spell')
      end,
    },
    { name = 'emoji' },
  },

  -- Customize the order of suggestions
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.order,         -- the order of the `sources` above
      compare.locality,      -- prefer matches closer in the file
      compare.recently_used, -- prefer more recently used
      require('cmp_fuzzy_buffer.compare'),
      compare.score,         -- compare entry scores
      compare.offset,        -- prefer less-distant matches (within separated words)
      compare.exact,
    }
  },

  -- Disable preselection (e.g. an exact match will be selected)
  preselect = cmp.PreselectMode.None,

  -- Customize the formatting/order of the completion popup
  formatting = {
    fields = { 'menu', 'kind', 'abbr' },
    format = function(entry, item)
      -- Keep this list in sync with the 'sources' above!
      -- Anything missing or blank will NOT display a label.
      local label = {
        copilot                  = 'AI',
        nvim_lsp                 = 'LSP',
        nvim_lsp_document_symbol = 'LSP sym',
        nvim_lsp_signature_help  = 'LSP help',
        nvim_lua                 = 'nvim',
        luasnip                  = 'snip',
        async_path               = '',
        git                      = 'git',
        spell                    = 'spell',
        fuzzy_buffer             = 'buf',
        emoji                    = '',
      }
      item.menu = label[entry.source.name]
      return item
    end,
  },

  mapping = {
    -- <Enter> key to confirm completion (but only if something is selected)
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
    }),

    -- <C-j> to select next entry (if visible)
    ['<C-j>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,

    -- <C-k> to select previous entry (if visible)
    ['<C-k>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,

    -- <C-c> to cancel, but only if an entry is selected
    ['<C-c>'] = function(fallback)
      if cmp.get_selected_entry() then
        cmp.abort()
      else
        fallback()
      end
    end,

    -- <C-space> to trigger completion manually
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Ignore <Tab> completely
    ['<Tab>'] = vim.NIL,
  },

  -- Add borders to the completion window
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})

-- Enable completion in git filetypes for git things
require("cmp_git").setup()

-- TODO: disabled for now
-- -- Enable completion for `/` and `?` searches
-- cmp.setup.cmdline({ '/', '?' }, {
--   -- mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'fuzzy_buffer' }
--   }
-- })

-- TODO: disabled for now
-- -- Enable completion for Ex commands
-- cmp.setup.cmdline(':', {
--   -- mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources(
--     {
--       { name = 'path' }
--     },
--     {
--       { name = 'cmdline' },
--       { name = 'cmdline_history' },
--     }
--   ),
--   enabled = function()
--     -- Set of commands where cmp will be disabled
--     local disabled = {
--         -- CmdNameHere = true
--     }
--     -- Get first word of cmdline
--     local cmd = vim.fn.getcmdline():match("%S+")
--     -- Return true if cmd isn't disabled
--     -- else call/return cmp.close(), which returns false
--     return not disabled[cmd] or cmp.close()
--   end,
-- })
