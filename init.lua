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
    {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts = {}, -- required, even if empty
    },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
    },
    {
        'mistweaverco/kulala.nvim',
        opts = {}
    },
    {
        "vim-test/vim-test",
        dependencies = {
            "tpope/vim-dispatch",
        }
    },
    {
        'echasnovski/mini.nvim',
        version = false
    },
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
    },
    {
        'stevearc/oil.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
    },
    "folke/neodev.nvim",
    "ionide/ionide-vim",
    "nvim-lualine/lualine.nvim",
    "godlygeek/tabular",
    "mbbill/undotree",
    "nvim-treesitter/nvim-treesitter",
    "tpope/vim-fugitive",
    "tpope/vim-commentary",
    "tpope/vim-dadbod",
    "github/copilot.vim"
})

require("options")
require("keybindings")

require("config/neodev")
require("config/oil")
require("config/lualine")
require("config/lsp")
require("config/treesitter")
require("config/telescope")
require("config/mini")
require("config/trouble")
require("config/kulala")
