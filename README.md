# neovim config

How to set up: 

```sh
git clone git@github.com:Frixxie/nvim-config.git .config/nvim
```

## keymaps

Leader key: `<Space>`

### lsp

- `gD` declaration
- `<leader>d` definition
- `<leader>D` type definition
- `<leader>i` implementation
- `K` hover
- `<leader>k` signature help
- `<leader>rn` rename
- `<leader>ca` code actions
- `<leader>r` references
- `<leader>f` format

### diagnostics

- `[d` previous diagnostic
- `]d` next diagnostic
- `<leader>e` diagnostic float
- `<leader>q` diagnostics to quickfix

### navigation and tools

- `<leader>p` find files (`FzfLua files`)
- `<leader>o` file explorer (`Oil`)
- `<leader>u` toggle `Undotree`
- `<leader>tn` nearest test
- `<leader>ts` test suite
