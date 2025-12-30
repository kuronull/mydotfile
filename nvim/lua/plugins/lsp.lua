return {
  -- 1. Quản lý cài đặt LSP Server
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    },
  },

  -- 2. Cầu nối giữa Mason và lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- Tự động cài đặt các server này nếu chưa có
      ensure_installed = {
        "pyright", "lua_ls", "rust_analyzer", 
        "clangd", "html", "cssls", "ts_ls"
      },
    },
  },

  -- 3. Cấu hình LSP Main
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Giúp LSP hiểu được Auto-completion
      { "folke/neodev.nvim", opts = {} }, -- Hỗ trợ viết code Lua/Nvim tốt hơn
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Hàm thiết lập phím tắt khi LSP kết nối thành công
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gr", "<cmd>Telescope lsp_references<cr>", "Show References")
        map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
      end

      -- Danh sách các server cần setup
      local servers = {
        pyright = {},
        rust_analyzer = {},
        clangd = {},
        html = {},
        cssls = {},
        ts_ls = {}, -- tsserver cũ
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
      }

      -- Tự động setup tất cả server trong danh sách trên
      for server, config in pairs(servers) do
        lspconfig[server].setup(vim.tbl_deep_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
        }, config))
      end

      -- Cấu hình UI cho thông báo lỗi (Diagnostic)
      vim.diagnostic.config({
        float = { border = "rounded" },
        virtual_text = { prefix = "●" },
      })
    end,
  },
}