return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "fredrikaverpil/neotest-golang", version = "*" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-golang")(),
        },
      })
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end,                          desc = "Run nearest test" },
      { "<leader>tT", function() require("neotest").run.run(vim.fn.expand("%")) end,        desc = "Run test file" },
      { "<leader>ts", function() require("neotest").run.run(vim.uv.cwd()) end,              desc = "Run test suite" },
      { "<leader>tl", function() require("neotest").run.run_last() end,                     desc = "Re-run last test" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end,      desc = "Show test output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,              desc = "Toggle output panel" },
      { "<leader>tp", function() require("neotest").summary.toggle() end,                   desc = "Toggle test summary" },
    },
  },
}
