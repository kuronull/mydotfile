return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header (tên custom của bạn)
    dashboard.section.header.val = {
      " █████╗ ██╗      █████╗ ██████╗ ██╗ ██████╗ ",
      "██╔══██╗██║     ██╔══██╗██╔══██╗██║██╔════╝ ",
      "███████║██║     ███████║██████╔╝██║██║      ",
      "██╔══██║██║     ██╔══██║██╔══██╗██║██║      ",
      "██║  ██║███████╗██║  ██║██║  ██║██║╚██████╗ ",
      "╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ ",
      "",
      "        👋 Welcome, AlaricLe",
    }

    -- Menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "📄  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "🔍  Find file", ":Telescope find_files <CR>"),
      dashboard.button("r", "🕘  Recent", ":Telescope oldfiles <CR>"),
      dashboard.button("c", "⚙️  Config", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("q", "🚪  Quit", ":qa<CR>"),
    }

    alpha.setup(dashboard.config)
  end,
}
