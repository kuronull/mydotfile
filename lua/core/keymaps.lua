vim.g.mapleader = " "

local map = vim.keymap.set

map("n","<leader>w", ":w<CR>")
map("n","<leader>q", ":q<CR>")

map("n","<C-h>", "<C-w>h")
map("n","<C-j>", "<C-w>j")
map("n","<C-k>", "<C-w>k")
map("n","<C-l>", "<C-w>l")

map("n", "<leader>sv", ":vsplit<CR>")   -- Vertical split
map("n", "<leader>sh", ":split<CR>")    -- Horizontal split
map("n", "<leader>sx", ":close<CR>")    -- Đóng cửa sổ hiện tại

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
