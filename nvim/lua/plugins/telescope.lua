return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x", -- Sử dụng branch ổn định thay vì khóa cứng commit quá cũ
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "truncate " },
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "   ",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },
          sorting_strategy = "ascending", -- Đưa thanh tìm kiếm lên đầu
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- Di chuyển lên bằng Ctrl-k
              ["<C-j>"] = actions.move_selection_next,     -- Di chuyển xuống bằng Ctrl-j
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Load các extensions sau khi setup
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
    end,
  },
}