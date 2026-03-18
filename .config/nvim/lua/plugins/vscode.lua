-- Plugins to disable when running inside VSCode (via vscode-neovim extension).
-- VSCode handles UI, LSP, completion, formatting, linting, and file management,
-- so we disable all LazyVim plugins that duplicate or conflict with those features.

local vscode = vim.g.vscode ~= nil

local function disable(plugins)
  local specs = {}
  for _, name in ipairs(plugins) do
    table.insert(specs, { name, enabled = not vscode })
  end
  return specs
end

return vim.list_extend(
  disable({
    -- Colorscheme / UI chrome (VSCode controls the theme)
    "tokyonight.nvim",
    "catppuccin",

    -- Status line & buffer tabs
    "lualine.nvim",
    "bufferline.nvim",

    -- Notification / command-line UI (conflicts with VSCode's own UI)
    "noice.nvim",
    "nvim-notify",

    -- Which-key (VSCode has its own keybinding UI)
    "which-key.nvim",

    -- Completion (VSCode handles completion)
    "blink.cmp",
    "friendly-snippets",

    -- LSP tooling (VSCode handles language services)
    "nvim-lspconfig",
    "mason.nvim",
    "mason-lspconfig.nvim",
    "lazydev.nvim",

    -- Formatting & linting (VSCode handles these)
    "conform.nvim",
    "nvim-lint",

    -- Git decorations (VSCode has built-in git gutter)
    "gitsigns.nvim",

    -- Diagnostics UI (VSCode shows diagnostics natively)
    "trouble.nvim",

    -- Dashboard / session management (not useful in VSCode)
    "persistence.nvim",

    -- File explorer (use VSCode's explorer instead)
    "neo-tree.nvim",

    -- Snacks (dashboard, scratch, etc. — not needed in VSCode)
    "snacks.nvim",
  }),
  {
    -- Keep treesitter for text objects / syntax, but disable slow parsers check
    {
      "nvim-treesitter",
      opts = {
        highlight = { enable = false }, -- VSCode already highlights syntax
      },
    },
  }
)
