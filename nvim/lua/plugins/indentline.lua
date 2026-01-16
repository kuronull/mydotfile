return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "│",      -- ký tự tạo đường line
      tab_char = "│",
    },
    scope = {
      enabled = true,  -- highlight block hiện tại
      show_start = false,
      show_end = false,
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    exclude = {
      filetypes = {
        "help",
        "dashboard",
        "lazy",
        "NvimTree",
        "neo-tree",
      },
    },
  },
}
