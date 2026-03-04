-- Bootstrap mini.deps
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Options and keybindings need to load first (leader key, etc.)
now(function()
    require("options")
    require("keybindings")
end)

-- Colorscheme must load early for initial screen draw
now(function()
    add({ source = 'rebelot/kanagawa.nvim' })
    require("kanagawa").load("wave")
end)

-- mini.nvim modules (already installed as the package manager itself)
now(function()
    require("config/mini")
end)

-- Statusline should be visible immediately
now(function()
    add({ source = 'nvim-lualine/lualine.nvim' })
    require("config/lualine")
end)

-- File explorer
now(function()
    add({
        source = 'stevearc/oil.nvim',
        depends = { 'nvim-tree/nvim-web-devicons' },
    })
    require("config/oil")
end)

-- Fuzzy finder
now(function()
    add({
        source = 'ibhagwan/fzf-lua',
        depends = { 'nvim-tree/nvim-web-devicons' },
    })
    require("config/fzf-lua")
end)

-- Completion engine
now(function()
    add({ source = 'rafamadriz/friendly-snippets' })
    add({
        source = 'saghen/blink.cmp',
        checkout = 'v1.9.1',
        depends = { 'rafamadriz/friendly-snippets' },
    })
    require("config/blink")
end)

-- LSP infrastructure
now(function()
    add({ source = 'neovim/nvim-lspconfig' })
    add({
        source = 'williamboman/mason.nvim',
        depends = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' },
    })
    add({ source = 'folke/neodev.nvim' })
    require("config/neodev")
    require("config/lsp")
end)

-- Treesitter
now(function()
    add({
        source = 'nvim-treesitter/nvim-treesitter',
        hooks = {
            post_checkout = function() vim.cmd('TSUpdate') end,
        },
    })
    require("config/treesitter")
end)

-- Endhints (lazy-loaded on LspAttach via autocommand)
later(function()
    add({ source = 'chrisgrieser/nvim-lsp-endhints' })
    vim.api.nvim_create_autocmd('LspAttach', {
        once = true,
        callback = function()
            require('lsp-endhints').setup()
        end,
    })
end)

-- Todo comments (deferred, non-critical UI)
later(function()
    add({
        source = 'folke/todo-comments.nvim',
        depends = { 'nvim-lua/plenary.nvim' },
    })
    require('todo-comments').setup({ signs = false })
end)

-- HTTP client
later(function()
    add({ source = 'mistweaverco/kulala.nvim' })
    require('kulala').setup()
    require("config/kulala")
end)

-- Testing
later(function()
    add({
        source = 'vim-test/vim-test',
        depends = { 'tpope/vim-dispatch' },
    })
end)

-- Git copilot
later(function()
    add({ source = 'github/copilot.vim' })
end)

-- Language support
later(function()
    add({ source = 'ionide/ionide-vim' })
end)

-- Utilities
later(function()
    add({ source = 'godlygeek/tabular' })
    add({ source = 'mbbill/undotree' })
    add({ source = 'tpope/vim-commentary' })
    add({ source = 'tpope/vim-dadbod' })
    add({ source = 'nvim-lua/plenary.nvim' })
    add({ source = 'kevinhwang91/nvim-bqf' })
end)
