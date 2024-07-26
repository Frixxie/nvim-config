vim.opt.undodir = vim.fn.stdpath("config") .. "~/.undodir"
vim.opt.undofile = true

vim.g.mapleader = " "

vim.g.have_nerd_font = true

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

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.cmd("let test#csharp#runner = 'dotnettest'")
vim.cmd("let test#strategy = 'dispatch'")

vim.g.latex_to_unicode_tab = "off"
vim.g.termguicolors = true

vim.g.copilot_enabled = false

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.cs" },
    command = "compiler dotnet",
})

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}

vim.cmd([[colorscheme catppuccin-mocha]])

vim.cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = true}") -- disabled in visual mode
