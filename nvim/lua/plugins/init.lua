-- 0. Tự động cài đặt Lazy.nvim nếu chưa có (Bootstrapping)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit...", "MoreMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 2. Cấu hình Lazy.nvim và Import các plugin
 require("lazy").setup({
  spec = {
      { import = "plugins.treesitter" },
      { import = "plugins.lsp" },
      { import = "plugins.telescope" },
      { import = "plugins.files" },
      { import = "plugins.alpha" },
      { import = "plugins.terminal" },
      { import = "plugins.theme" },
      { import = "plugins.indentline"}
    -- Import toàn bộ file trong thư mục lua/plugins
  },
  -- 3. Cấu hình giao diện và hệ thống cho Lazy
  defaults = {
    lazy = false, -- Các plugin sẽ load ngay lập tức trừ khi có cấu hình lazy cụ thể
    version = false, -- Luôn dùng bản mới nhất (stable)
  },
  change_detection = {
    enabled = true, -- Vẫn cho phép tự động load cấu hình mới
    notify = false,  -- NHƯNG tắt cái thông báo phiền phức đó đi
  },
  install = { colorscheme = { "habamax" } }, -- Theme tạm thời khi cài đặt
  ui = {
    border = "rounded", -- Viền bo tròn cho cửa sổ Lazy
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  checker = { enabled = true }, -- Tự động kiểm tra bản cập nhật cho plugin
})
