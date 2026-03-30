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
    gh("github/copilot.vim"),
    gh("rafamadriz/friendly-snippets"),
    { src = gh("saghen/blink.cmp"), version = "v1.9.1" },
    gh("williamboman/mason.nvim"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("mistweaverco/kulala.nvim"),
})

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
