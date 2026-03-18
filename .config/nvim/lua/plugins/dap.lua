return {
  -- Core DAP client
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- DAP UI
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
          { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
          { "<leader>de", function() require("dapui").eval() end,   desc = "Eval expression", mode = { "n", "v" } },
        },
        opts = {},
        config = function(_, opts)
          local dap, dapui = require("dap"), require("dapui")
          dapui.setup(opts)
          -- Auto-open/close UI on debug events
          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
          dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
        end,
      },
      -- Virtual text showing variable values inline
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,        desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                         desc = "Continue" },
      { "<leader>dn", function() require("dap").step_over() end,                                        desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end,                                        desc = "Step into" },
      { "<leader>do", function() require("dap").step_out() end,                                         desc = "Step out" },
      { "<leader>dq", function() require("dap").terminate() end,                                        desc = "Terminate" },
      { "<leader>dr", function() require("dap").repl.open() end,                                        desc = "Open REPL" },
      -- F-key shortcuts for active debugging (avoids F10/F11/F12 grabbed by terminal/DE)
      { "<F5>",       function() require("dap").continue() end,                                         desc = "Debug: Continue" },
      { "<F6>",       function() require("dap").step_over() end,                                        desc = "Debug: Step over" },
      { "<F7>",       function() require("dap").step_into() end,                                        desc = "Debug: Step into" },
      { "<F8>",       function() require("dap").step_out() end,                                         desc = "Debug: Step out" },
      { "<F9>",       function() require("dap").toggle_breakpoint() end,                                desc = "Debug: Toggle breakpoint" },
    },
  },

  -- Go adapter (uses delve)
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup({
        delve = {
          path = vim.fn.expand("~/go/bin/dlv"),
        },
        dap_configurations = {
          {
            type = "go",
            name = "Debug package",
            request = "launch",
            program = "${fileDirname}", -- whole package, not just the open file
            buildFlags = "",
          },
          {
            type = "go",
            name = "Debug package (args)",
            request = "launch",
            program = "${fileDirname}",
            buildFlags = "",
            args = function()
              return coroutine.create(function(co)
                vim.ui.input({ prompt = "Args: " }, function(input)
                  coroutine.resume(co, vim.split(input or "", " ", { trimempty = true }))
                end)
              end)
            end,
          },
        },
      })
    end,
    keys = {
      { "<leader>dt", function() require("dap-go").debug_test() end,      desc = "Debug nearest Go test" },
      { "<leader>dT", function() require("dap-go").debug_last_test() end, desc = "Re-run last Go test" },
    },
  },
}
