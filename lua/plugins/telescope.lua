return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    -- KHÓA VỀ COMMIT HAY TAG CŨ HƠN (còn hoạt động trên 0.10.0)
    -- Ví dụ tag v0.9.2:
    -- tag = "v0.2.0",
    commit = "3d757e586ff0bfc85bdb7b46c9d3d932147a0cde",
    config = function()
      require("telescope").setup {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
  },
}
