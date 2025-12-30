return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte | frappe | macchiato | mocha
      transparent_background = false,

      styles = {
        comments = { "italic" },
        keywords = { "italic" },
        functions = {},
        variables = {},
      },

      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        indent_blankline = {
          enabled = true,
          scope_color = "mauve",
          colored_indent_levels = false,
        },
        nvimtree = true,
        cmp = true,
        gitsigns = true,
        lualine = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
