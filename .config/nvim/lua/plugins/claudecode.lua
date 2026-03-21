return {
  {
    "coder/claudecode.nvim",
    enabled = false,
    dependencies = { "folke/snacks.nvim" },
    opts = {
      -- Use tmux pane for Claude Code, not a Neovim buffer.
      -- Launch Claude Code manually with: claude --ide
      terminal = {
        provider = "none",
      },
    },
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Claude: toggle" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Claude: focus" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Claude: resume" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",             desc = "Claude: send selection" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Claude: add current buffer" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Claude: accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Claude: deny diff" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Claude: add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
    },
  },
}
