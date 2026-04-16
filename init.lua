local gh = function(x) return "https://github.com/" .. x end


-- Run TSUpdate after treesitter is installed or updated
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" and (ev.data.kind == "install" or ev.data.kind == "update") then
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    gh("echasnovski/mini.nvim"),
    gh("rebelot/kanagawa.nvim"),
    gh("stevearc/oil.nvim"),
    gh("ibhagwan/fzf-lua"),
    gh("rafamadriz/friendly-snippets"),
    { src = gh("saghen/blink.cmp"), version = "v1.10.2" },
    gh("neovim/nvim-lspconfig"),
    gh("williamboman/mason.nvim"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("mistweaverco/kulala.nvim"),
})

vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")

require("options")
require("keybindings")

require("kanagawa").load("wave")

require("config/mini")
require("config/oil")
require("config/fzf-lua")
require("config/blink")
require("config/lsp")
require("config/treesitter")
require("config/kulala")

require("status")

vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy" }
vim.opt.pumborder = "rounded"

require('vim._core.ui2').enable({})
