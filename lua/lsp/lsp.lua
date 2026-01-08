require 'lsp.keybindings'

-- -- set the debug level for lsp
vim.lsp.set_log_level("warn")

local lsp_signature = require('lsp_signature')
lsp_signature.setup({})

-- feed lsp into the completion engine
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- attach the lsp_signature plugin for param help
local on_attach = function(_, bufnr)
  lsp_signature.on_attach({}, bufnr)
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

-- see ftplugin/*.lua
