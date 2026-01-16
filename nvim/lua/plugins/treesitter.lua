return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- sử dụng master branch
    build = ":TSUpdate",
    -- Sử dụng 'opts' thay cho 'config' giúp tránh lỗi module not found
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "python",
        "javascript", "typescript", "tsx",
        "html", "css", "json",
        "markdown", "markdown_inline",
        "bash", "c", "cpp", "rust",
        "yaml", "toml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          node_decremental = "<bs>",
        },
      },
    },
    -- Hàm này đảm bảo treesitter được config đúng cách
    config = function(_, opts)
      require("lazy").setup(opts)
    end,
  },
}
