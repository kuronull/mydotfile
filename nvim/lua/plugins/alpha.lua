return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header: Đã được căn chỉnh lại và đổi tên thành HungLe
    dashboard.section.header.val = {
      [[      ██╗  ██╗██╗   ██╗███╗   ██╗ ██████╗ ██╗     ███████╗      ]],
      [[      ██║  ██║██║   ██║████╗  ██║██╔════╝ ██║     ██╔════╝      ]],
      [[      ███████║██║   ██║██╔██╗ ██║██║  ███╗██║     █████╗        ]],
      [[      ██╔══██║██║   ██║██║╚██╗██║██║   ██║██║     ██╔══╝        ]],
      [[      ██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝███████╗███████╗      ]],
      [[      ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝      ]],
      "",
      "                👋 Welcome back, HungLe",
    }

    -- Menu: Tối ưu các shortcut và thêm highlight group cho đẹp
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files<cr>"),
      dashboard.button("r", "󰄉  Recent", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("c", "  Config", "<cmd>e $MYVIMRC<cr>"),
      dashboard.button("q", "󰩈  Quit", "<cmd>qa<cr>"),
    }

    -- Tùy chỉnh màu sắc (Optional)
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButton"

    alpha.setup(dashboard.config)

    -- Tự động mở Alpha khi đóng buffer cuối cùng (tùy chọn)
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        vim.opt.showtabline = 0 -- Ẩn tabline ở màn hình dashboard
      end,
    })
  end,
}