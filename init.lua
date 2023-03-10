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
  "windwp/nvim-autopairs",
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-web-devicons",
  "nvim-tree/nvim-tree.lua",
  "joshdick/onedark.vim",
  "godlygeek/tabular",
  "mbbill/undotree",
  "tpope/vim-commentary",
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
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",
  "rust-lang/rust.vim",
})

require("options")
require("keybindings")

require("config/lualine")
require("config/nvimtree")
require("config/telescope")
require("config/lsp")
require("config/cmp")
require("config/treesitter")
require("config/autopairs")
require("config/formatter")
require("config/gitsigns")
