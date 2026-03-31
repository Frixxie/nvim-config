local gh = function(x) return "https://github.com/" .. x end

-- Disable copilot.vim's built-in completions (using native LSP inline completion instead)
vim.g.copilot_filetypes = { ["*"] = false }
vim.g.copilot_no_maps = true

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
    { src = gh("saghen/blink.cmp"), version = "v1.10.2" },
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
vim.opt.pumborder = "rounded"

-- :PackClean - find and remove plugins on disk that are not in the lockfile
vim.api.nvim_create_user_command("PackClean", function()
    local lockfile = vim.fn.stdpath("config") .. "/nvim-pack-lock.json"
    local pack_root = vim.fn.stdpath("data") .. "/site/pack"

    -- Read and parse the lockfile to get declared plugin names
    local ok, content = pcall(vim.fn.readfile, lockfile)
    if not ok then
        vim.notify("PackClean: could not read " .. lockfile, vim.log.levels.ERROR)
        return
    end

    local lock = vim.json.decode(table.concat(content, "\n"))
    local declared = {}
    for name, _ in pairs(lock.plugins or {}) do
        declared[name] = true
    end

    -- Scan all pack/{group}/{start,opt}/* directories for installed plugins
    local unused = {}
    local groups = vim.fn.globpath(pack_root, "*", false, true)
    for _, group_dir in ipairs(groups) do
        for _, kind in ipairs({ "start", "opt" }) do
            local plugin_dirs = vim.fn.globpath(group_dir .. "/" .. kind, "*", false, true)
            for _, plugin_dir in ipairs(plugin_dirs) do
                local name = vim.fn.fnamemodify(plugin_dir, ":t")
                if not declared[name] then
                    table.insert(unused, plugin_dir)
                end
            end
        end
    end

    if #unused == 0 then
        vim.notify("PackClean: no unused plugins found", vim.log.levels.INFO)
        return
    end

    -- Show what will be removed and ask for confirmation
    local lines = { "The following unused plugins will be removed:\n" }
    for _, dir in ipairs(unused) do
        table.insert(lines, "  " .. dir)
    end
    table.insert(lines, "\nRemove " .. #unused .. " plugin(s)? [y/N] ")

    vim.ui.input({ prompt = table.concat(lines, "\n") }, function(input)
        if not input or input:lower() ~= "y" then
            vim.notify("PackClean: aborted", vim.log.levels.INFO)
            return
        end

        local removed = 0
        for _, dir in ipairs(unused) do
            local rm_ok = vim.fn.delete(dir, "rf")
            if rm_ok == 0 then
                removed = removed + 1
            else
                vim.notify("PackClean: failed to remove " .. dir, vim.log.levels.WARN)
            end
        end
        vim.notify("PackClean: removed " .. removed .. " plugin(s)", vim.log.levels.INFO)
    end)
end, { desc = "Remove plugins on disk that are not declared in the lockfile" })

require('vim._core.ui2').enable({})
