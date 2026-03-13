-- Zero-plugin Neovim configuration
-- Requires Neovim 0.11+

require("options")
require("keybindings")

-- Colorscheme (built-in, change to your preference: habamax, retrobox, zaibatsu, sorbet, wildcharm)
vim.cmd.colorscheme("retrobox")

-- Jujutsu (jj) statusline component
local jj_status = ""
local function jj_refresh()
    vim.system(
        { "jj", "log", "--no-graph", "-r", "@", "-T", "if(bookmarks, bookmarks, change_id.short(8))" },
        { text = true },
        function(obj)
            local result = ""
            if obj.code == 0 and obj.stdout then
                result = vim.trim(obj.stdout)
            end
            vim.schedule(function() jj_status = result end)
        end
    )
end
jj_refresh()
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, { callback = jj_refresh })

function JjStatus()
    if jj_status == "" then return "" end
    return " jj:" .. jj_status .. " "
end

function LspStatus()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return "" end
    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end
    return " lsp:" .. table.concat(names, ",") .. " "
end

-- Simple statusline
vim.opt.statusline = " %f %m%r%h%w%=%{v:lua.LspStatus()}%{v:lua.JjStatus()}%y  %l:%c  %p%% "

-- Completion settings
vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy" }

-- Completion keymaps: Tab/S-Tab to navigate popup or jump snippets
vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n>"
    elseif vim.snippet.active({ direction = 1 }) then
        return "<cmd>lua vim.snippet.jump(1)<CR>"
    else
        return "<Tab>"
    end
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-p>"
    elseif vim.snippet.active({ direction = -1 }) then
        return "<cmd>lua vim.snippet.jump(-1)<CR>"
    else
        return "<S-Tab>"
    end
end, { expr = true })

-- Restore cursor position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})

-- Treesitter highlighting for any filetype with an available parser
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- LSP keymaps and built-in completion on attach
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end
        local bufnr = ev.buf
        local opts = { buffer = bufnr }

        -- Set omnifunc for manual <C-x><C-o> completion
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Enable built-in completion
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

        -- Enable inlay hints
        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        -- LSP keymaps
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
            )
        end, { buffer = bufnr, desc = "Toggle inlay hints" })
    end,
})

-- Enable LSP servers (configs live in lsp/*.lua)
vim.lsp.enable({
    "ts_ls",
    "clangd",
    "ruff",
    "pyright",
    "csharp_ls",
    "hls",
    "rust_analyzer",
    "tinymist",
    "harper_ls",
})
