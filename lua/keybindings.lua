vim.keymap.set("n", "<silent><CR>", ":nohlsearch<CR>", {})
vim.keymap.set("n", "<leader>r<space>", "mm:%s/[\t ]*$//g<CR>:noh<CR>'mzz", {})
vim.keymap.set("n", "<leader>n", ":noh<cr>", {})
vim.keymap.set("n", "<leader>w", ":w!<cr>", {})
vim.keymap.set("n", "<leader>o", ":Oil<cr>", {})
vim.keymap.set("n", "<leader>p", ":FzfLua files<cr>", {})
vim.keymap.set("n", "<leader>co", ":copen<cr>", {})
vim.keymap.set("n", "<leader>cn", ":cnext<cr>", {})
vim.keymap.set("n", "<leader>cp", ":cprev<cr>", {})

vim.keymap.set("v", "<C-c>", '"+ygv', {})
vim.keymap.set("t", "<leader><esc>", "<C-\\><C-n>", {})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
