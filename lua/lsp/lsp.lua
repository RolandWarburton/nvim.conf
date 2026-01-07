require 'lsp.keybindings'

-- -- set the debug level for lsp
vim.lsp.set_log_level("warn")

-- feed lsp into the completion engine
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- attach the lsp_signature plugin for param help
local on_attach = function(client, bufnr)
  require('lsp_signature').on_attach({}, bufnr)
end

-- display diagnostics for LSP errors
vim.diagnostic.config({
  virtual_text = false, -- change this to enable inline errors
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
})

vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach,
  root_markers = { '.git' },
})

---------------------
-- lsp configurations
---------------------

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
          [vim.fn.expand("$HOME/.local/luarocks/5.1")] = true,
        },
      },
    },
  },
})
vim.lsp.enable('lua_ls')

vim.lsp.config('denols', {})
vim.lsp.enable('denols')

-- ts_ls: denols seems to handle most typescript projects
-- vim.lsp.config('ts_ls', {})
-- vim.lsp.enable('ts_ls')

vim.lsp.config('ansiblels', {})
vim.lsp.enable('ansiblels')

vim.lsp.config('gopls', {})
vim.lsp.enable('gopls')

vim.lsp.config('postgres_lsp', {})
vim.lsp.enable('postgres_lsp')
