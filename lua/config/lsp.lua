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

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "omnisharp",
        "clangd",
        "hls",
        "denols",
        "svelte",
        "dockerfile-language-server",
        "docker-compose-language-server"
    }
})

require("lspconfig")["dockerfile-language-server"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig")["docker-compose-language-server"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig")["clangd"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig")["denols"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig")["svelte"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig")["hls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig")["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig")["omnisharp"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig")["rust_analyzer"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
