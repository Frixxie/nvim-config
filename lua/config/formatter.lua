local latexindent = function()
  return {
    exe = "latexindent",
    args = {},
    stdin = true,
  }
end

local hindent = function()
  return {
    exe = "hindent",
    args = {},
    stdin = true,
  }
end

-- Formatting
local astyle_format = function()
  return {
    exe = "astyle",
    args = {},
    stdin = true,
  }
end

local dotnetfmt = function()
  return {
    exe = "dotnet",
    args = { "format" },
    stdin = false,
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    rust = {
      function()
        return {
          exe = "rustfmt",
          args = { "--emit=stdout", "--edition=2020" },
          stdin = true,
        }
      end,
    },
    python = {
      function()
        return {
          exe = "autopep8",
          args = { "-" },
          stdin = true,
        }
      end,
    },
    c = {
      astyle_format,
    },
    cpp = {
      astyle_format,
    },
    cs = {
      dotnetfmt,
    },
    latex = {
      latexindent,
    },
    tex = {
      latexindent,
    },
    haskell = {
      hindent,
    },
    lua = {
      -- Stylua
      function()
        return {
          exe = "stylua",
          args = { "--indent-width", 2, "--indent-type", "Spaces" },
          stdin = false,
        }
      end,
    },
    go = {
      -- gofmt
      function()
        return {
          exe = "gofmt",
          args = { "" },
          stdin = true,
        }
      end,
    },
  },
})
