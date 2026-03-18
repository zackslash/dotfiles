-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
  local vscode = require("vscode")

  -- Window/split navigation — delegate to VSCode's workbench commands
  vim.keymap.set("n", "<C-h>", function() vscode.action("workbench.action.focusLeftGroup") end)
  vim.keymap.set("n", "<C-l>", function() vscode.action("workbench.action.focusRightGroup") end)
  vim.keymap.set("n", "<C-j>", function() vscode.action("workbench.action.focusBelowGroup") end)
  vim.keymap.set("n", "<C-k>", function() vscode.action("workbench.action.focusAboveGroup") end)

  -- File/buffer navigation
  vim.keymap.set("n", "<leader>ff", function() vscode.action("workbench.action.quickOpen") end)
  vim.keymap.set("n", "<leader>fg", function() vscode.action("workbench.action.findInFiles") end)
  vim.keymap.set("n", "<leader>e",  function() vscode.action("workbench.action.toggleSidebarVisibility") end)

  -- LSP actions via VSCode
  vim.keymap.set("n", "gd", function() vscode.action("editor.action.revealDefinition") end)
  vim.keymap.set("n", "gr", function() vscode.action("editor.action.goToReferences") end)
  vim.keymap.set("n", "gi", function() vscode.action("editor.action.goToImplementation") end)
  vim.keymap.set("n", "K",  function() vscode.action("editor.action.showHover") end)
  vim.keymap.set("n", "<leader>ca", function() vscode.action("editor.action.quickFix") end)
  vim.keymap.set("n", "<leader>cr", function() vscode.action("editor.action.rename") end)

  -- Diagnostics
  vim.keymap.set("n", "]d", function() vscode.action("editor.action.marker.nextInFiles") end)
  vim.keymap.set("n", "[d", function() vscode.action("editor.action.marker.prevInFiles") end)

  -- Formatting
  vim.keymap.set({ "n", "v" }, "<leader>cf", function() vscode.action("editor.action.formatDocument") end)
end
