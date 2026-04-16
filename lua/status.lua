local jj_status = ""
local jj_ahead = 0

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

    vim.system(
        { "jj", "log", "--no-graph", "-r", "::@ & ~::trunk()", "-T", [[".\n"]] },
        { text = true },
        function(obj)
            local count = 0
            if obj.code == 0 and obj.stdout then
                local trimmed = vim.trim(obj.stdout)
                if trimmed ~= "" then
                    -- Count the number of lines (each commit outputs one line)
                    for _ in trimmed:gmatch("[^\n]+") do
                        count = count + 1
                    end
                end
            end
            vim.schedule(function()
                jj_ahead = count
            end)
        end
    )
end

_G.JjStatus = function()
    if jj_status == "" then
        return ""
    end
    local s = " jj:" .. jj_status
    if jj_ahead > 0 then
        s = s .. " +" .. jj_ahead
    end
    return s .. " "
end

_G.DiagStatus = function()
    local buf = vim.api.nvim_get_current_buf()
    local e = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.ERROR })
    local w = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.WARN })
    local h = #vim.diagnostic.get(buf, { severity = vim.diagnostic.severity.HINT })
    if e == 0 and w == 0 and h == 0 then
        return ""
    end
    local parts = {}
    if e > 0 then table.insert(parts, "E:" .. e) end
    if w > 0 then table.insert(parts, "W:" .. w) end
    if h > 0 then table.insert(parts, "H:" .. h) end
    return " [" .. table.concat(parts, " ") .. "]" .. " "
end

_G.copilot_enabled = false

_G.LspStatus = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local names = {}
    for _, client in ipairs(clients) do
        if client.name ~= "copilot" and client.name ~= "GitHub Copilot" then
            table.insert(names, client.name)
        end
    end

    local copilot_indicator = _G.copilot_enabled and " [copilot]" or ""
    if #names == 0 then
        return " lsp:none" .. copilot_indicator .. " "
    end

    return " lsp:" .. table.concat(names, ",") .. copilot_indicator .. " "
end

jj_refresh()

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, { callback = jj_refresh })

vim.opt.statusline = " %f %m%r%h%w%=%{v:lua.DiagStatus()}%{v:lua.LspStatus()}%{v:lua.JjStatus()}%y  %l:%c  %p%% "
