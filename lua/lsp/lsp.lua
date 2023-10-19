require'lsp.keybindings'

-- set the debug level for lsp
vim.lsp.set_log_level("debug")

-- we need this for lsp servers
-- it allows us to define what files define the root of a project
local root_pattern = require("lspconfig").util.root_pattern

local lsp_config = require('lspconfig')

-- feed lsp into the completion engine
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  -- attach the lsp_signature plugin for param help
  require'lsp_signature'.on_attach()
end

-- javascript/typescript
require 'lspconfig'.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = { hostInfo = "neovim" },
  root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
}

-- GOLANG
lsp_config.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = lsp_config.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

-- HTML
require'lspconfig'.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  }
}

-- LUA
USER = vim.fn.expand('$USER')
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = true,
      },
    },
  },
}
