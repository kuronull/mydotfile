return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]], -- Phím tắt để mở/đóng terminal
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float", -- Mặc định mở kiểu nổi (float)
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "rounded",
        winblend = 3,
      },
    })

    -- Các phím tắt bổ trợ cho Terminal
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- Dùng jk hoặc Esc để thoát Insert mode trong terminal
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      -- Di chuyển giữa các cửa sổ nhanh từ terminal
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    -- Chỉ kích hoạt các phím tắt này khi mở terminal
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}