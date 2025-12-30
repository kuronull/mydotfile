return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000, -- Đảm bảo theme luôn load đầu tiên
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false, -- Ẩn các dấu ~ ở cuối file cho sạch
      term_colors = true,
      dim_inactive = {
        enabled = false, -- Làm tối cửa sổ không hoạt động
        shade = "dark",
        percentage = 0.15,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        -- Tích hợp thêm cho các plugin bạn đang dùng
        telescope = {
          enabled = true,
          style = "nvchad", -- Style hiện đại giống NVChad
        },
        mason = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        which_key = true,
        indent_blankline = {
          enabled = true,
          scope_color = "mauve", -- Màu của đường kẻ thụt lề đang đứng
          colored_indent_levels = false,
        },
      },
    })

    -- Thiết lập màu nền cho Dashboard Alpha nếu cần
    vim.cmd.colorscheme("catppuccin")
  end,
}