-- Khởi động Lazy.nvim và setup các plugin từ các file con
-- Đảm bảo đã install lazy.nvim ở ~/.config/nvim/lazy hoặc dùng lazy installer script

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  -- Tự động clone lazy.nvim nếu chưa có
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Khuyến nghị dùng branch stable
    lazy_path
  })
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
--  { import = "plugins.colorscheme" },   -- cấu hình theme
  { import = "plugins.lsp" },           -- cấu hình LSP
  { import = "plugins.treesitter" },    -- cấu hình Treesitter
  { import = "plugins.telescope" },     -- cấu hình Telescope
  { import = "plugins.files" },          -- cau hinh file
  { import = "plugins.alpha" }
  { import = "plugins.terminal"}
  { import = "plugins.theme"}
  -- bạn thêm các plugin khác theo mong muốn, ví dụ:
 }, {
  -- Các tùy chỉnh cho Lazy.nvim (optional)
  ui = {
    border = "rounded"
  },
  defaults = {
    lazy = false,
    version = false,
  },
})
