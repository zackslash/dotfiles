return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        -- style = "dark", -- "dark" or "light" (follows vim.o.background by default)
        transparent = false,
        italic_comments = true,
        italic_inlayhints = true,
        underline_links = true,
        disable_nvimtree_bg = true,
        terminal_colors = true,
      })
      vim.cmd.colorscheme("vscode")
    end,
  },
}
