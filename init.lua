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
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
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
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',

        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = { preset = 'default' },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                -- optionally disable cmdline completions
                -- cmdline = {},
            },

            -- experimental signature help support
            signature = { enabled = true }
        },
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" }
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
    "github/copilot.vim",
    {
        "nvim-lua/plenary.nvim",
        branch = "master"
    }
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
require("config/kulala")
require("config/codecompanion")
