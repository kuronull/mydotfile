-- lua/core/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Tạo group để tránh việc duplicate autocmd khi reload config
local mygroup = augroup("MyAutoCmds", { clear = true })

-- 1. Thiết lập cấu hình theo loại file (Buffer-local options)
autocmd("FileType", {
  group = mygroup,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.spell = true      -- Gợi ý: Bật kiểm tra chính tả cho text
    vim.opt_local.wrap = true       -- Gợi ý: Tự động xuống dòng giả lập (visual wrap)
  end,
  desc = "Set local options for text-based files",
})

-- 2. Tự động format khi lưu (Cải tiến để không mất vị trí con trỏ)
autocmd("BufWritePre", {
  group = mygroup,
  pattern = { "*.md", "*.txt" }, -- gitcommit thường không cần vì nó đóng sau khi lưu
  callback = function()
    -- Lưu lại vị trí con trỏ hiện tại
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    
    -- Thực thi lệnh format mà không làm mất lịch sử jump (keepjumps)
    vim.cmd([[keepjumps normal! gggqG]])
    
    -- Trả con trỏ về vị trí cũ (nếu dòng cũ vẫn tồn tại sau khi format)
    pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
  end,
  desc = "Auto-format text width on save without losing cursor position",
})

-- 3. Highlight khi yank (Copy) - Một autocmd cực kỳ hữu ích nên có
autocmd("TextYankPost", {
  group = mygroup,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight text when yanking",
})
