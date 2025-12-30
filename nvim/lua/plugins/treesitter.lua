return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- Nên dùng bản master để có các parser mới nhất
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        -- Danh sách ngôn ngữ cài đặt tự động
        ensure_installed = {
          "lua", "vim", "vimdoc", "python", "javascript", "typescript", 
          "tsx", "html", "css", "markdown", "markdown_inline", 
          "json", "bash", "c", "cpp", "rust", "yaml", "toml"
        },
        
        -- Tự động cài đặt parser nếu vào file chưa có
        auto_install = true,

        highlight = {
          enable = true,
          -- Giúp màu sắc của Catppuccin/LSP không bị ghi đè lỗi thời
          additional_vim_regex_highlighting = false,
        },

        indent = { 
          enable = true 
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>", -- Dùng Ctrl+Space để bắt đầu chọn vùng code
            node_incremental = "<C-space>", -- Nhấn tiếp để mở rộng vùng chọn (theo khối)
            scope_incremental = false,
            node_decremental = "<bs>", -- Nhấn Backspace để thu nhỏ vùng chọn
          },
        },

        -- Cấu hình textobjects (giúp thao tác nhanh với function, class)
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Tự động nhảy đến textobj tiếp theo
            keymaps = {
              ["af"] = "@function.outer", -- Chọn toàn bộ hàm (outer)
              ["if"] = "@function.inner", -- Chọn nội dung trong hàm (inner)
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
}