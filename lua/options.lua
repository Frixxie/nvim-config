local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir
vim.opt.undofile = true

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.list = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.cs" },
    command = "compiler dotnet",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.gleam" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

vim.g.markdown_fenced_languages = {
    "ts=typescript",
}

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ on_visual = true })
    end,
})

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.g.copilot_no_tab_map = true
