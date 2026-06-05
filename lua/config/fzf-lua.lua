require('fzf-lua').setup()

vim.keymap.set("n", "<leader>p", ":FzfLua files<cr>", {})
vim.keymap.set("n", "<leader>fg", ":FzfLua grep<cr>", {})
vim.keymap.set("n", "<leader>fgl", ":FzfLua live_grep<cr>", {})
