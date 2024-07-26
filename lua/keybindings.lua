vim.keymap.set("n", "<silent><CR>", ":nohlsearch<CR>", {})
vim.keymap.set("n", "<leader>r<space>", "mm:%s/[\t ]*$//g<CR>:noh<CR>'mzz", {})
vim.keymap.set("n", "<leader>n", ":noh<cr>", {})
vim.keymap.set("n", "<leader>w", ":w!<cr>", {})
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", {})
vim.keymap.set("n", "ff", ":Format<cr>", {})
vim.keymap.set("n", "<leader>o", ":Oil<cr>", {})
vim.keymap.set("n", "<leader>cp", ":Copilot enable<cr>", {})
vim.keymap.set("n", "<leader>g", ":tab G<cr>", {})
vim.keymap.set("n", "<leader>tn", ":TestNearest<cr>", {})

-- For copy paste
vim.keymap.set("v", "<C-c>", '"+ygv', {})
-- to escape the terminal
vim.keymap.set("t", "<leader><esc>", "<C-\\><C-n>", {})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
