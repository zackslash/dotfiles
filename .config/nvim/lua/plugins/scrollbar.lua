return {
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      require("scrollbar").setup({
        handlers = {
          gitsigns = true,
          diagnostic = true,
          cursor = true,
        },
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
}
