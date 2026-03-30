local ts = require("nvim-treesitter")

ts.install({
    "c",
    "cpp",
    "c_sharp",
    "haskell",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "rust",
    "tsx",
    "typst",
    "typescript",
    "vim",
    "vimdoc",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "c",
        "cpp",
        "cs",
        "haskell",
        "javascript",
        "javascriptreact",
        "lhaskell",
        "lua",
        "python",
        "rust",
        "typst",
        "typescript",
        "typescriptreact",
        "vim",
        "vimdoc",
    },
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "haskell", "lhaskell" },
    callback = function(args)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
