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
  "nvim-tree/nvim-web-devicons",
  "nvim-tree/nvim-tree.lua",
  "joshdick/onedark.vim",
  "godlygeek/tabular",
  "mbbill/undotree",
  "tpope/vim-commentary",
  "tpope/vim-dispatch",
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/nvim-cmp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "mhartington/formatter.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "folke/neodev.nvim",
  "tpope/vim-fugitive",
  "vim-test/vim-test",
  "lewis6991/gitsigns.nvim",
  "rust-lang/rust.vim",
  { 'echasnovski/mini.nvim', version = false },
  "github/copilot.vim",
  "catppuccin/nvim",
  "folke/trouble.nvim",
})

require("options")
require("keybindings")

require("config/dap")
require("config/lualine")
require("config/nvimtree")
require("config/telescope")
require("config/lsp")
require("config/cmp")
require("config/treesitter")
require("config/formatter")
require("config/gitsigns")
require("config/mini")
