return {
    cmd = { "copilot-language-server", "--stdio" },
    init_options = {
        editorInfo = {
            name = "Neovim",
            version = tostring(vim.version()),
        },
        editorPluginInfo = {
            name = "Neovim",
            version = tostring(vim.version()),
        },
    },
    settings = {
        github = {
            copilot = {
                selectedCompletionModel = "claude-4.5-haiku",
            },
        },
    },
    root_markers = { ".git" },
}
