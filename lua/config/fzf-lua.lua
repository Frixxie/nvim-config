require('fzf-lua').setup()

vim.keymap.set("n", "<leader>p", ":FzfLua files<cr>", {})
