vim.keymap.set("n", "<silent><CR>", ":nohlsearch<CR>", {})
vim.keymap.set("n", "<leader>r<space>", "mm:%s/[\t ]*$//g<CR>:noh<CR>'mzz", {})
vim.keymap.set("n", "<leader>n", ":noh<cr>", {})
vim.keymap.set("n", "<leader>w", ":w!<cr>", {})
vim.keymap.set("n", "<leader>o", ":Explore<cr>", {})
vim.keymap.set("n", "<leader>co", ":copen<cr>", {})
vim.keymap.set("n", "<leader>cn", ":cnext<cr>", {})
vim.keymap.set("n", "<leader>cp", ":cprev<cr>", {})

-- Close quickfix window after selecting an item, restore cursor for Fd results
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function(event)
        vim.keymap.set("n", "<CR>", function()
            local qf_title = vim.fn.getqflist({ title = 1 }).title
            local idx = vim.fn.line(".")
            vim.cmd("cclose")
            vim.cmd(idx .. "cc")
            if qf_title == "fd" then
                local mark = vim.api.nvim_buf_get_mark(0, '"')
                local line_count = vim.api.nvim_buf_line_count(0)
                if mark[1] > 0 and mark[1] <= line_count then
                    vim.api.nvim_win_set_cursor(0, mark)
                end
            end
        end, { buffer = event.buf })
    end,
})

-- File finder using fd -> quickfix
vim.api.nvim_create_user_command("Fd", function(opts)
    local pattern = opts.args
    local cmd = "fd --hidden --exclude .git " .. pattern

    local results = {}
    for file in io.popen(cmd):lines() do
        table.insert(results, { filename = file, lnum = 1 })
    end

    vim.fn.setqflist({}, " ", { title = "fd", items = results })
    vim.cmd("copen")
end, { nargs = 1 })

vim.keymap.set("n", "<leader>p", ":Fd ", {})

-- Copy to system clipboard
vim.keymap.set("v", "<C-c>", '"+ygv', {})

-- Terminal escape
vim.keymap.set("t", "<leader><esc>", "<C-\\><C-n>", {})

-- Diagnostics
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
