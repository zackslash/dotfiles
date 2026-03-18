-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false

if vim.g.vscode then
  -- Let VSCode control all visual chrome
  vim.opt.cmdheight = 1
  vim.opt.laststatus = 0  -- hide status line (VSCode has its own)
  vim.opt.showtabline = 0 -- hide tabline
  vim.opt.ruler = false
  vim.opt.showmode = false
  vim.opt.swapfile = false -- VSCode manages buffers
end
