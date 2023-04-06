-- Set color scheme
vim.opt.background = 'dark'
vim.cmd('colorscheme base16-eighties')
vim.g.airline_theme = "base16_eighties_custom"

-- Terminal colors hackery
vim.cmd([[
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
]])

-- Fix MatchParens highlighting in comments with base16 colorschemes
vim.api.nvim_create_augroup('on_change_colorscheme', { clear = true })
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  group = 'on_change_colorscheme',
  pattern = '*',
  callback = function()
    vim.fn['Base16hi'](
    "MatchParen",
    vim.g.base16_gui05,
    vim.g.base16_gui03,
    vim.g.base16_cterm05,
    vim.g.base16_cterm03,
    "bold,italic",
    ""
    )
  end
})

-- Highlight yanked text
vim.api.nvim_create_augroup('on_yank', { clear = true })
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = 'on_yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      timeout = 500,
      higroup = "Visual",
    })
  end
})
