-- 1. Thiết lập Leader key (nên đặt đầu file)
vim.g.mapleader = " ".config/nvim

-- 2. Rút gọn hàm set keymap để code sạch hơn
local map = vim.keymap.set

-----------------------------------------------------------
-- Hệ thống Keybindings
-----------------------------------------------------------

-- Thao tác File nhanh
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Di chuyển giữa các Window (Cửa sổ)
-- Sử dụng Ctrl + h/j/k/l thay vì Ctrl-w + h/j/k/l
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Quản lý Chia màn hình (Splits)
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split horizontal" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Telescope (Tìm kiếm)
-- Sử dụng <cmd> thay cho : và <cr> để thực thi lệnh mượt hơn
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- NvimTree (Trình quản lý file)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- Auto format code
map("n", "<leader>c", vim.diagnostic.open_float, { desc = "Show diagnostics" })

-- code action (quick fix in vscode)
map( "n", "<leader>b", vim.lsp.buf.code_action, { desc = "Code action (Quick Fix)" })
