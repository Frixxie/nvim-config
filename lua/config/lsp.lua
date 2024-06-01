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
        "dockerls",
        "docker_compose_language_service",
        "tailwindcss",
        "tsserver",
        "sqlls",
        "csharp_ls",
        "fsautocomplete"
    }
})

require("lspconfig")["helm_ls"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["fsautocomplete"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["sqlls"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["tsserver"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["tailwindcss"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["dockerls"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["docker_compose_language_service"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["clangd"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
-- require("lspconfig")["denols"].setup({
--     on_attach = on_attach,
-- omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
-- })
require("lspconfig")["svelte"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["hls"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["lua_ls"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["omnisharp"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["rust_analyzer"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["ocamllsp"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
require("lspconfig")["pyright"].setup({
    on_attach = on_attach,
    omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
})
