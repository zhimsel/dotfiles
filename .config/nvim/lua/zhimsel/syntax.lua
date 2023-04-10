-- Set up syntax-related things separate from lazy.nvim


-- Set up LSP

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()


require('mason-lspconfig').setup({
  automatic_installation = true
})


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
