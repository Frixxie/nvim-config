require('fzf-lua').setup({'fzf-native'})

vim.keymap.set("n", "<leader>p", ":FzfLua files<cr>", {})
