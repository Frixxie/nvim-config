local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "nvim-lualine/lualine.nvim",
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    "nvim-tree/nvim-web-devicons",
    "godlygeek/tabular",
    "mbbill/undotree",
    "neovim/nvim-lspconfig",
    "mhartington/formatter.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "folke/neodev.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-commentary",
    "tpope/vim-dispatch",
    "tpope/vim-dadbod",
    "vim-test/vim-test",
    "lewis6991/gitsigns.nvim",
    "rust-lang/rust.vim",
    { 'echasnovski/mini.nvim', version = false },
    "github/copilot.vim",
    "catppuccin/nvim",
    "chentoast/marks.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "ibhagwan/fzf-lua",
    "sindrets/diffview.nvim"
})

require("options")
require("keybindings")

require("config/dap")
require("config/oil")
require("config/lualine")
require("config/fzf")
require("config/lsp")
require("config/treesitter")
require("config/formatter")
require("config/gitsigns")
require("config/mini")
require("config/marks")
