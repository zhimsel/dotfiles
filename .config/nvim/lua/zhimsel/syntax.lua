-- Set up syntax-related things separate from lazy.nvim


-- Set up LSP

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)


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

lsp.setup()


-- Set up completion

local cmp = require('cmp')

cmp.setup({
  -- order matters here! this is how they will be sorted in the list
  sources = {
    { name = 'nvim_lsp' },
    { name = 'aync_path' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer', option = {
      keyword_length = 2,
      keyword_pattern = [[\k\+]], -- use vim's `iskeyword` option for recognizing words
    }},
    { name = 'emoji' },
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
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
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

    -- <Esc> to cancel, but only if an entry is selected
    ['<Esc>'] = function(fallback)
      if cmp.get_selected_entry() then
        cmp.abort()
      else
        fallback()
      end
    end,
  }
})
