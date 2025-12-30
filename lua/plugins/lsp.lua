return {
  -- Plugin LSP main
  {
    "neovim/nvim-lspconfig",
    version = "0.1.8",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")

      -- Python
      lspconfig.pyright.setup{}

      -- Lua
      lspconfig.lua_ls.setup{
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          }
        }
      }

      -- Rust
      lspconfig.rust_analyzer.setup{}

      -- C, C++
      lspconfig.clangd.setup{}

      -- HTML
      lspconfig.html.setup{}

      -- CSS
      lspconfig.cssls.setup{}

      -- JavaScript & TypeScript
      lspconfig.tsserver.setup{}

      -- Bạn bổ sung các lsp khác cho ngôn ngữ thêm ở đây nếu cần
    end
  },

  -- Plugin hỗ trợ cài đặt LSP server
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
    lazy = false,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    config = true,
    lazy = false,
  },
}
