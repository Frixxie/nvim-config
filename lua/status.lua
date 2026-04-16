local jj_status = ""
local jj_ahead = 0

local function jj_refresh()
    if vim.fn.executable("jj") ~= 1 then
        return
    end

    vim.system(
        { "jj", "log", "--no-graph", "-r", "@", "-T",
            "if(bookmarks, bookmarks, change_id.short(8)) ++ \" \" ++ count(::@ & ~::trunk())" },
        { text = true },
        function(obj)
            if obj.code ~= 0 or not obj.stdout then
                vim.schedule(function()
                    jj_status = ""
                    jj_ahead = 0
                end)
                return
            end
            local output = vim.trim(obj.stdout)
            local name, count = output:match("^(.+)%s+(%d+)$")
            vim.schedule(function()
                jj_status = name or output
                jj_ahead = tonumber(count) or 0
            end)
        end
    )
end

_G.JjStatus = function()
    if jj_status == "" then
        return ""
    end
    local s = "jj:" .. jj_status
    if jj_ahead > 0 then
        s = s .. " +" .. jj_ahead
    end
    return s
end

_G.DiagStatus = function()
    local diags = vim.diagnostic.get(vim.api.nvim_get_current_buf())
    if #diags == 0 then
        return ""
    end
    local counts = { 0, 0, 0, 0 }
    for _, d in ipairs(diags) do
        counts[d.severity] = counts[d.severity] + 1
    end
    local parts = {}
    if counts[1] > 0 then parts[#parts + 1] = "E:" .. counts[1] end
    if counts[2] > 0 then parts[#parts + 1] = "W:" .. counts[2] end
    if counts[4] > 0 then parts[#parts + 1] = "H:" .. counts[4] end
    return "[" .. table.concat(parts, " ") .. "]"
end

_G.copilot_enabled = false

_G.LspStatus = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local names = {}
    for _, client in ipairs(clients) do
        if client.name ~= "copilot" and client.name ~= "GitHub Copilot" then
            names[#names + 1] = client.name
        end
    end

    local copilot_indicator = _G.copilot_enabled and " [copilot]" or ""
    if #names == 0 then
        if copilot_indicator ~= "" then
            return copilot_indicator:sub(2)
        end
        return ""
    end

    return "lsp:" .. table.concat(names, ",") .. copilot_indicator
end

jj_refresh()

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, { callback = jj_refresh })

vim.opt.statusline = " %f %m%r%= %{v:lua.DiagStatus()} %{v:lua.LspStatus()} %{v:lua.JjStatus()} %y  %l:%c  %p%% "
