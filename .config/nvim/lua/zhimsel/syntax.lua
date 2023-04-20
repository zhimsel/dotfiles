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

local lsp = require('lsp-zero')

lsp.preset({
  name = 'recommended',
  float_border = 'rounded',
  manage_nvim_cmp = {
    set_sources          = false, -- manually configured below
    set_basic_mappings   = false, -- manually configured below
    set_extra_mappings   = true,
    use_luasnip          = true,
    set_format           = true
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
  map('n', 'gd', '<cmd>Telescope lsp_definitions<cr>',      { buffer = true })
  map('n', 'gD', '<cmd>Telescope lsp_declarations<cr>',     { buffer = true })
  map('n', 'gi', '<cmd>Telescope lsp_implementations<cr>',  { buffer = true })
  map('n', 'gr', '<cmd>Telescope lsp_references<cr>',       { buffer = true })
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
})

-- Add border around lspconfig floating windows
require('lspconfig.ui.windows').default_options.border = 'rounded'

lsp.setup()


-- Set up completion

local cmp = require('cmp')
local compare = require('cmp.config.compare')

-- Set up cmp
cmp.setup({
  -- Order and grouping matters here!
  -- This is how they will be sorted and grouped in the completion popup.
  sources = {
    { name = 'nvim_lsp' },
    { name = 'aync_path' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'git' },
    { name = 'fuzzy_buffer' },
    { name = 'emoji' },
  },

  sorting = {
    priority_weight = 2,
    comparators = {
      compare.order, -- prioritizes "sources" order above all else
      require('cmp_fuzzy_buffer.compare'),
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
    }
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
      -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
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

    -- <Esc> to confirm, but only if an entry is selected
    ['<Esc>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),

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
