return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",              desc = "Diff view (working tree)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",     desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",       desc = "Branch history" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>",             desc = "Close diff view" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal", -- side-by-side
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
      },
    },
  },
}
