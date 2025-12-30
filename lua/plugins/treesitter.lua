return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "lua", "vim", "python", "javascript", "typescript", "html",
          "css", "markdown", "json", "bash", "c", "cpp", "rust"
        },
        highlight = {
          enable = true,          -- Bật highlight code
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true           -- Bật auto-indent thông minh
        },
        incremental_selection = {
          enable = true,
          keymaps = { 
            init_selection    = "gnn",
            node_incremental  = "grn",
            scope_incremental = "grc",
            node_decremental  = "grm",
          },
        },
        -- Nếu cần thêm module, mở rộng ở đây (textobjects, playground, ...)
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
}
}
