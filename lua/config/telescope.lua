require("telescope").setup()
require("telescope").load_extension('fzf')


local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>p", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fc", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fm", builtin.marks, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>ft", builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set("n", "<leader>z", builtin.spell_suggest, {})
vim.keymap.set("n", "<leader>ts", builtin.treesitter, {})
