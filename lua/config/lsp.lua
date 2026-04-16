require("mason").setup()

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

local blink_capabilities = require("blink.cmp").get_lsp_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
            return
        end

        local bufnr = ev.buf
        local opts = { buffer = bufnr }

        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
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

vim.lsp.config("*", {
    capabilities = blink_capabilities,
})

vim.lsp.enable({
    "ts_ls",
    "clangd",
    "ruff",
    "pyright",
    "omnisharp",
    "hls",
    "rust_analyzer",
    "tinymist",
    "harper_ls",
})

vim.lsp.inline_completion.enable()

function ToggleCopilot()
    local clients = vim.lsp.get_clients({ name = "copilot" })
    if #clients > 0 then
        for _, client in ipairs(clients) do
            client:stop()
        end
        vim.notify("Copilot disabled")
    else
        vim.lsp.enable("copilot")
        vim.notify("Copilot enabled")
    end
end

vim.keymap.set("i", "<C-l>", function()
    if not vim.lsp.inline_completion.get() then
        return "<C-l>"
    end
end, { expr = true, desc = "Accept the current inline completion" })
