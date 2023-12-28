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
require("mason-lspconfig").setup()

require("lspconfig")["omnisharp"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
require("lspconfig")["rust_analyzer"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- require("lspconfig").pylsp.setup({
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodesyle = {
--                     ignore = { "W391" },
--                     maxLineLength = 100,
--                 },
--             },
--         },
--     },
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })

-- require("lspconfig")["denols"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })

-- require("lspconfig")["csharp_ls"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     --     filetypes = {"cs", "csx"}
-- })
-- require("lspconfig")["omnisharp"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     cmd = { "dotnet", "/Users/fredrik/opts/omnisharp-osx-arm64-net6.0/OmniSharp.dll" },

--     -- Enables support for reading code style, naming convention and analyzer
--     -- settings from .editorconfig.
--     enable_editorconfig_support = false,

--     -- If true, MSBuild project system will only load projects for files that
--     -- were opened in the editor. This setting is useful for big C# codebases
--     -- and allows for faster initialization of code navigation features only
--     -- for projects that are relevant to code that is being edited. With this
--     -- setting enabled OmniSharp may load fewer projects and may thus display
--     -- incomplete reference lists for symbols.
--     enable_ms_build_load_projects_on_demand = false,

--     -- Enables support for roslyn analyzers, code fixes and rulesets.
--     enable_roslyn_analyzers = true,

--     -- Specifies whether 'using' directives should be grouped and sorted during
--     -- document formatting.
--     organize_imports_on_format = true,

--     -- Enables support for showing unimported types and unimported extension
--     -- methods in completion lists. When committed, the appropriate using
--     -- directive will be added at the top of the current file. This option can
--     -- have a negative impact on initial completion responsiveness,
--     -- particularly for the first few completion sessions after opening a
--     -- solution.
--     enable_import_completion = true,

--     -- Specifies whether to include preview versions of the .NET SDK when
--     -- determining which version to use for project loading.
--     sdk_include_prereleases = true,

--     -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
--     -- true
--     analyze_open_documents_only = false,
-- })
-- require("lspconfig")["texlab"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- -- require("lspconfig")["grammarly"].setup({
-- --     on_attach = on_attach,
-- --     filetypes = { "tex", "markdown" },
-- --     capabilities = capabilities,
-- -- })
-- require("lspconfig")["marksman"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- require("lspconfig")["clangd"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- require("lspconfig")["svelte"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- require("lspconfig")["tsserver"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- require("lspconfig")["rust_analyzer"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- require("lspconfig")["hls"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- require("lspconfig")["fsautocomplete"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- require("lspconfig")["tailwindcss"].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
-- require 'lspconfig'.lua_ls.setup {
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = { 'vim' },
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = vim.api.nvim_get_runtime_file("", true),
--             },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
