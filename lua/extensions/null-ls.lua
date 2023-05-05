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
  diagnostics.eslint,
  code_actions.eslint,
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#prettier=
  formatting.prettier,
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
  -- format markdown with prettier
  formatting.prettierd.with({
    filetypes = {
      "markdown"
    }
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
        vim.fn.expand('%:p')
      }
    end
  }),

  -------------------------------------------------------------------------------------------------
  -- GOLANG ---------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  -- https://github.com/JohnnyMorganz/StyLua
null_ls.builtins.formatting.stylua.with({
    extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
}),
  -------------------------------------------------------------------------------------------------
  -- GITSIGNS -------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------
  code_actions.gitsigns,
}

null_ls.setup({
  debug = true,
  sources = sources,
})
