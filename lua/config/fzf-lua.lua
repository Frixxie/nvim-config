require('fzf-lua').setup()
vim.cmd([[FzfLua register_ui_select]])

vim.keymap.set("n", "<leader>p", ":FzfLua files<cr>", {})
