-- lua/core/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local mygroup = augroup("MyAutoCmds", { clear = true })

-- Tự động đặt textwidth cho các loại file cần xuống dòng tự động, ví dụ markdown hoặc text
autocmd("FileType", {
  group = mygroup,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.textwidth = 80 -- hoặc 72, tuỳ nhu cầu
  end
})

-- Tự động format lại dòng khi lưu file (quá dài thì xuống dòng)
autocmd("BufWritePre", {
  group = mygroup,
  pattern = { "*.md", "*.txt", "*.gitcommit" },
  command = "normal! gggqG"
})
