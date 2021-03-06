-- null-ls configuration

-- you can check if you have a linter installed for a language by running
-- (for example to check eslint) :echo executable('eslint')
-- 1 indicates it is present
local null_ls = require'null-ls'

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

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
      return {
        "--stdin",
        "--config",
        require'os'.getenv('HOME') .. "/.config/nvim/conf/markdownlint.json"
      }
    end
  }),
  -------------------------------------------------------------------------------------------------
  -- VALE -----------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#vale
  diagnostics.vale.with({
    args = function(params)
      return {
        "--no-exit",
        "--output",
        "JSON",
        "--ext",
        ".",
        "--config",
        require'os'.getenv('HOME') .. "/.config/nvim/conf/vale.ini",
        vim.fn.expand('%:p') -- prints the absolute file path
      }
    end
  }),
  -------------------------------------------------------------------------------------------------
  -- GOLANG ---------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#gofmt=
  formatting.gofmt.with({
    command = "gofmt",
    args = function(params)
      return {
        vim.fn.expand('%p')
      }
    end
  }),
  --   .with({
  --   _opts = {
  --     command = {"go", "fmt"},
  --     to_stdin = true
  --   }
  -- }),
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#golangci_lint=
  -- waiting for generics support
  -- diagnostics.golangci_lint.with({
  --   args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" }
  -- }),
  -------------------------------------------------------------------------------------------------
  -- GITSIGNS -------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  code_actions.gitsigns,
}

null_ls.setup({
  debug = true,
  sources = sources,
})
