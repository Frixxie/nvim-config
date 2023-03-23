vim.opt.undodir = vim.fn.stdpath("config") .. "~/.undodir"
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

vim.g.latex_to_unicode_tab = "off"
vim.g.termguicolors = true

vim.cmd([[colorscheme onedark]])

vim.cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = true}") -- disabled in visual mode

vim.diagnostic.show()
