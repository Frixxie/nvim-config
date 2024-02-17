require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>p", ":FzfLua files<CR>", {})
vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<CR>", {})
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>", {})
vim.keymap.set("n", "<leader>ft", ":FzfLua lsp_live_workspace_symbols<CR>", {})
