local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"

if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim",
        mini_path,
    })
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require("mini.deps").setup({ path = { package = path_package } })

local add, now = MiniDeps.add, MiniDeps.now

now(function()
    require("options")
    require("keybindings")
end)

now(function()
    add({ source = "rebelot/kanagawa.nvim" })
    require("kanagawa").load("wave")
end)

now(function()
    require("config/mini")
end)

now(function()
    add({ source = "stevearc/oil.nvim" })
    require("config/oil")
end)

now(function()
    add({ source = "ibhagwan/fzf-lua" })
    require("config/fzf-lua")
end)

now(function()
    add({ source = "github/copilot.vim" })
end)

now(function()
    add({ source = "rafamadriz/friendly-snippets" })
    add({
        source = "saghen/blink.cmp",
        checkout = "v1.9.1",
        depends = { "rafamadriz/friendly-snippets" },
    })
    require("config/blink")
end)

now(function()
    add({ source = "williamboman/mason.nvim" })
    require("config/lsp")
end)

now(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        hooks = {
            post_checkout = function()
                vim.cmd("TSUpdate")
            end,
        },
    })
    require("config/treesitter")
end)

now(function()
    add({ source = "mistweaverco/kulala.nvim" })
    require("config/kulala")
end)

local jj_status = ""

local function jj_refresh()
    if vim.fn.executable("jj") ~= 1 then
        return
    end

    vim.system(
        { "jj", "log", "--no-graph", "-r", "@", "-T", "if(bookmarks, bookmarks, change_id.short(8))" },
        { text = true },
        function(obj)
            local result = ""
            if obj.code == 0 and obj.stdout then
                result = vim.trim(obj.stdout)
            end
            vim.schedule(function()
                jj_status = result
            end)
        end
    )
end

_G.JjStatus = function()
    if jj_status == "" then
        return ""
    end
    return " jj:" .. jj_status .. " "
end

_G.LspStatus = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return ""
    end

    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end

    return " lsp:" .. table.concat(names, ",") .. " "
end

jj_refresh()

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, { callback = jj_refresh })

vim.opt.statusline = " %f %m%r%h%w%=%{v:lua.LspStatus()}%{v:lua.JjStatus()}%y  %l:%c  %p%% "
vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy" }
