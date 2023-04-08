-- Terminal colors hackery
vim.cmd([[
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
]])

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
