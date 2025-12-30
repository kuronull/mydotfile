local option = vim.opt

------------------
---Hiển thị và Giao diện
------------------
option.number = true -- hiện số dòng
option.relativenumber = true -- hiển thị số dòng tương đối
option.cursorline = true -- highlight dòng hiện tại
--option.termguicolors = true -- hỗ trợ màu sắc 24-bit

------------------
---Thụt lề và Tab
------------------
option.expandtab = true -- chuyển tab thành. khoảng trắng
option.shiftwidth = 4
option.smartindent = true -- tự động thụt lề thông minh khi xuống dỏng


------------------
---Tìm kiếm (Search)
------------------
option.ignorecase = true 
option.smartcase = true -- nếu gõ chữ hoa, nó sẽ tự động tìm kiếm chính xác


------------------
---Hệ thống và Hiệu năng
------------------
option.clipboard = "unnamedplus"