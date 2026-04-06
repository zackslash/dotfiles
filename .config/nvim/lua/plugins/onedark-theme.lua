return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "warm",
        transparent = false,
        term_colors = true,
        code_style = {
          comments = "italic",
        },
        highlights = {
          Comment = { fg = "#6A9955", fmt = "italic" },
          ["@comment"] = { fg = "#6A9955", fmt = "italic" },
          ["@comment.documentation"] = { fg = "#6A9955", fmt = "italic" },
          ["@comment.todo"] = { fmt = "italic" },
          ["@comment.note"] = { fmt = "italic" },
          ["@comment.warning"] = { fmt = "italic" },
          ["@comment.error"] = { fmt = "italic" },
          ["@lsp.type.comment"] = { fg = "#6A9955", fmt = "italic" },
          LspInlayHint = { fg = "#5c6370", fmt = "italic" },
          ["@lsp.type.inlayHint"] = { fg = "#5c6370", fmt = "italic" },
          ["@text.reference"] = { fmt = "underline" },
          ["@markup.link"] = { fmt = "underline" },
          ["@markup.link.label"] = { fmt = "underline" },
          ["@variable"] = { fg = "#abb2bf" },
          ["@variable.parameter"] = { fg = "#abb2bf" },
          ["@variable.builtin"] = { fg = "#e5c07b" },
          ["@variable.member"] = { fg = "#e06c75" },
          ["@lsp.type.variable"] = { fg = "#abb2bf" },
          ["@lsp.mod.defaultLibrary"] = { fg = "#e5c07b" },
          ["@function.call"] = { fg = "#61afef" },
          ["@method.call"] = { fg = "#61afef", fmt = "italic" },
          ["@function.method.call"] = { fg = "#61afef", fmt = "italic" },
          ["@type"] = { fg = "#e5c07b" },
          ["@field"] = { fg = "#e06c75" },
          ["@constant"] = { fg = "#d19a66" },
          ["@keyword"] = { fg = "#c678dd" },
          ["@namespace"] = { fg = "#56b6c2" },
          ["@module"] = { fg = "#56b6c2" },
          ["@lsp.type.function"] = { fg = "#61afef" },
          ["@lsp.type.method"] = { fg = "#61afef", fmt = "italic" },
          ["@lsp.type.type"] = { fg = "#e5c07b" },
          ["@lsp.type.property"] = { fg = "#e06c75" },
          ["@lsp.type.constant"] = { fg = "#d19a66" },
          ["@lsp.type.keyword"] = { fg = "#c678dd" },
          ["@lsp.type.namespace"] = { fg = "#56b6c2" },
          NvimTreeNormal = { bg = "none" },
          NvimTreeNormalNC = { bg = "none" },
        },
      })
      vim.cmd.colorscheme("onedark")
      vim.api.nvim_set_hl(0, "Comment", { fg = "#6A9955", italic = true })
      vim.api.nvim_set_hl(0, "@comment", { fg = "#6A9955", italic = true })
      vim.api.nvim_set_hl(0, "@comment.documentation", { fg = "#6A9955", italic = true })
      vim.api.nvim_set_hl(0, "@lsp.type.comment", { fg = "#6A9955", italic = true })
      vim.api.nvim_set_hl(0, "@lsp.type.comment.go", { fg = "#6A9955", italic = true })
    end,
  },
}
