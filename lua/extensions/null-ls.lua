-- null-ls configuration

-- you can check if you have a linter installed for a language by running
-- (for example to check eslint) :echo executable('eslint')
-- 1 indicates it is present
local null_ls = require'null-ls';
local formatting = null_ls.builtins.formatting;
local diagnostics = null_ls.builtins.diagnostics;

local sources = {
  -------------------------------------------------------------------------------------------------
  -- JAVASCRIPT/TYPESCRIPT ------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#eslint=
  diagnostics.eslint_d,
  formatting.eslint_d,
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#prettier=
  formatting.prettierd.with({
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "html",
      "json",
      "jsonc",
      "yaml",
      "graphql",
      "handlebars"
    }
  }),
  -------------------------------------------------------------------------------------------------
  -- MARKDOWN -------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#markdownlint=
  diagnostics.markdownlint.with({
    args = function(params)
      return {"--stdin", "--config", "/home/roland/.markdownlint.json"}
    end
  }),
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#vale
  diagnostics.vale.with({
    args = function(params)
      return { "--no-exit", "--output", "JSON", "--ext", ".", "--config", home .. "/.config/.vale.ini", vim.fn.expand('%:p')}
    end
  }),
  -------------------------------------------------------------------------------------------------
  -- GOLANG ---------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#golangci_lint=
  formatting.gofmt.with({
    _opts = {
      command = "gofmt -s",
      to_stdin = true
    }
  }),
  --  https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#golangci_lint=
  diagnostics.golangci_lint.with({
    args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" }
  })
}

null_ls.setup({
  debug = true,
  sources = sources,
})
