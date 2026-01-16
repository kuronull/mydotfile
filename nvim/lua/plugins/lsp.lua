return {
  -- 1. Mason quản lý các Server (Tải về máy)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = { ui = { border = "rounded" } },
  },

  -- 2. Mason-LSPConfig (Tự động kết nối server với Neovim)
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- Danh sách server cho các ngôn ngữ bạn yêu cầu:
      ensure_installed = {
        "pyright",       -- Python
        "rust_analyzer", -- Rust
        "html",          -- HTML
        "cssls",         -- CSS
        "ts_ls",         -- JavaScript/TypeScript (thường đi kèm web)
        "lua_ls",        -- Lua (cho chính Neovim)
      },
    },
  },

  -- 3. Bộ máy Autocomplete (Cái Menu hiện ra khi gõ)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- Đây là nguồn lấy từ các ngôn ngữ Python, Rust...
          { name = "luasnip" },
        }),
      })
    end,
  },

  -- 4. Kích hoạt Server (Sửa lỗi "require('lspconfig') is deprecated")
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Thiết lập phím tắt LSP chuẩn mới (LspAttach)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Đi tới định nghĩa
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)       -- Xem thông tin hàm
        end,
      })

      -- Vòng lặp kích hoạt từng ngôn ngữ để tránh gọi trực tiếp 'lspconfig' gây lỗi
      local servers = { "pyright", "rust_analyzer", "html", "cssls", "ts_ls", "lua_ls" }
      for _, lsp in ipairs(servers) do
          if vim.lsp.config then
            vim.lsp.config(lsp, {
                capabilities = capabilities,
            })
            vim.lsp.enable(lsp)
          else
            require('lspconfig')[lsp].setup({
                capabilities = capabilities,
            })
          end
       end
    end
  }
}
