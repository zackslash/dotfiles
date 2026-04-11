-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local json_no_autoformat = vim.api.nvim_create_augroup("json_no_autoformat", { clear = true })
local checktime_reload = vim.api.nvim_create_augroup("checktime_reload", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = json_no_autoformat,
  pattern = { "json", "jsonc" },
  desc = "Disable LazyVim autoformat for json/jsonc",
  callback = function(event)
    vim.b[event.buf].autoformat = false
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = checktime_reload,
  desc = "Reload files changed outside Neovim",
  callback = function(args)
    if vim.fn.mode() == "c" then
      return
    end

    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    if vim.api.nvim_buf_get_name(args.buf) == "" then
      return
    end

    vim.cmd("checktime")
  end,
})
