require('zhimsel.options')
require('zhimsel.key-maps')
require('zhimsel.visual')

local ok, _ = pcall(require, 'zhimsel_local')

-- Bootstrap package manager if it's not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Start up package manager
-- Load spec from lua/zhimsel/plugins/* and config from lua/zhimsel/lazy.lua
require("lazy").setup("zhimsel.plugins", require("zhimsel.lazy"))

-- Set up LSP, autocompletion, highlighting, etc.
require('zhimsel.syntax')

-- Enable syntax highlighting, in case it was disabled (should always be last)
vim.cmd.syntax('enable')
