return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        -- Tự động cập nhật thư mục gốc khi bạn thay đổi thư mục trong terminal
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        
        view = {
          width = 35, -- Tăng nhẹ chiều rộng để dễ đọc tên file dài
          side = "left",
          number = false,
          relativenumber = false,
        },

        renderer = {
          highlight_git = true, -- Highlight tên file theo trạng thái git
          indent_markers = {
            enable = true, -- Hiển thị đường kẻ thụt lề cho dễ nhìn
          },
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },

        filters = {
          dotfiles = false,
          custom = { ".DS_Store" }, -- Ẩn các file rác hệ thống
        },

        actions = {
          open_file = {
            quit_on_open = true, -- Tự động đóng tree sau khi chọn file để làm việc
            window_picker = {
              enable = false, -- Tắt bộ chọn cửa sổ nếu bạn thấy phiền
            },
          },
        },
      })
    end,
  },
}