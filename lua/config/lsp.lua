-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pycodesyle = {
                    ignore = { "W391" },
                    maxLineLength = 100,
                },
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})
require("lspconfig")["csharp_ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"cs", "csx"}
})
require("lspconfig")["texlab"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
-- require("lspconfig")["grammarly"].setup({
--     on_attach = on_attach,
--     filetypes = { "tex", "markdown" },
--     capabilities = capabilities,
-- })
-- require("lspconfig")["marksman"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
require("lspconfig")["clangd"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
require("lspconfig")["svelte"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
require("lspconfig")["tsserver"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
require("lspconfig")["rust_analyzer"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
require("lspconfig")["fsautocomplete"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
require("lspconfig")["tailwindcss"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
require 'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
}
