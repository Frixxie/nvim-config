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
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
    },
    "godlygeek/tabular",
    "mbbill/undotree",
    "mhartington/formatter.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/popup.nvim",
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
    },
    "folke/neodev.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-commentary",
    "tpope/vim-dispatch",
    "tpope/vim-dadbod",
    "vim-test/vim-test",
    "rust-lang/rust.vim",
    {
        'echasnovski/mini.nvim',
        version = false
    },
    "github/copilot.vim",
    "catppuccin/nvim",
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        }
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build =
                'make'
            },
            "gbrlsnchs/telescope-lsp-handlers.nvim"
        }
    },
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false }
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "otavioschwanck/arrow.nvim",
        opts = {
            show_icons = true,
            leader_key = ';', -- Recommended to be a single key
        }
    }
})

require("options")
require("keybindings")

require("config/dap")
require("config/neodev")
require("config/oil")
require("config/lualine")
require("config/lsp")
require("config/treesitter")
require("config/formatter")
require("config/telescope")
require("config/mini")
require("config/trouble")
