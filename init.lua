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
        "OXY2DEV/markview.nvim",
        lazy = false, -- Recommended
        -- ft = "markdown" -- If you decide to lazy-load anyway

        dependencies = {
            -- You will not need this if you installed the
            -- parsers manually
            -- Or if the parsers are in your $RUNTIMEPATH
            "nvim-treesitter/nvim-treesitter",

            "nvim-tree/nvim-web-devicons"
        }
    },
    "nvim-lualine/lualine.nvim",
    "godlygeek/tabular",
    "mbbill/undotree",
    "mhartington/formatter.nvim",
    "nvim-treesitter/nvim-treesitter",
    "github/copilot.vim",
    "joshdick/onedark.vim",
    "folke/neodev.nvim",
    "ionide/ionide-vim",
    'mistweaverco/kulala.nvim',
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim", -- Optional
            {
                "stevearc/dressing.nvim",    -- Optional: Improves the default Neovim UI
                opts = {},
            },
        },
        config = true
    },
    "tpope/vim-fugitive",
    "tpope/vim-commentary",
    "tpope/vim-dadbod",
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
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
require("config/kulala")
require("config/codecompanion")
