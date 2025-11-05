-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "hls",
        "clangd",
        "ruff",
        "pyright",
        "omnisharp",
        "rust_analyzer",
        "denols",
        "csharp_ls"
    },
    automatic_installation = true,
})

local caps = require('blink.cmp').get_lsp_capabilities()

-- require("lspconfig")["tailwindcss"].setup({
--     on_attach = on_attach,
--     capbabilities = caps
-- })
-- require("lspconfig")["clangd"].setup({
--     on_attach = on_attach,
--     capbabilities = caps
-- })
-- require("lspconfig")["ts_ls"].setup({
--     on_attach = on_attach,
--     capbabilities = caps
-- })
-- require("lspconfig")["svelte"].setup({
--     on_attach = on_attach,
--     capbabilities = caps
-- })
-- require("lspconfig")["hls"].setup({
--     on_attach = on_attach,
--     capbabilities = caps
-- })
-- require("lspconfig")["lua_ls"].setup({
--     on_attach = on_attach,
--     capbabilities = caps
-- })
vim.lsp.enable('clangd')
vim.lsp.config('clangd', {
    on_attach = on_attach,
    capbabilities = caps
})
vim.lsp.enable('ruff')
vim.lsp.config('ruff', {
    on_attach = on_attach,
    capbabilities = caps
})
vim.lsp.enable('pyright')
vim.lsp.config('pyright', {
    on_attach = on_attach,
    capbabilities = caps
})
vim.lsp.enable('omnisharp')
vim.lsp.config('omnisharp', {
    on_attach = on_attach,
    capbabilities = caps
})
vim.lsp.enable('hls')
vim.lsp.config('hls', {
    on_attach = on_attach,
    capbabilities = caps
})
vim.lsp.enable('csharp_ls')
vim.lsp.config('csharp_ls', {
    on_attach = on_attach,
    capbabilities = caps
})
vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
    on_attach = on_attach,
    capbabilities = caps
})
vim.lsp.enable('denols')
vim.lsp.config('denols', {
    on_attach = on_attach,
    capbabilities = caps
})
