require 'lsp.keybindings'

local home = os.getenv("HOME")
home = home == nil and "/home/roland" or home

-- set the debug level for lsp
vim.lsp.set_log_level("warn")

-- define some shorthand
local lsp_config = require('lspconfig')
local root_pattern = require("lspconfig").util.root_pattern

-- feed lsp into the completion engine
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  -- attach the lsp_signature plugin for param help
  require 'lsp_signature'.on_attach()
end

-- javascript/typescript
require 'lspconfig'.ts_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = { hostInfo = "neovim" },
  root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
  single_file_support = false -- stops ts_ls messing with deno
}

-- deno
require 'lspconfig'.denols.setup {
  cmd = { home .. "/.deno/bin/deno", "lsp" },
  init_options = {
    lint = true,
    unstable = true,
  },
  root_dir = root_pattern("deno.json", "deno.jsonc"),
}

-- GOLANG
lsp_config.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = root_pattern("go.work", "go.mod", ".git"),
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
require 'lspconfig'.html.setup {
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
require 'lspconfig'.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        path = {
          "./?.lua",                                     -- Current directory
          home .. "/.luarocks/share/lua/5.1/?/init.lua", -- Luarocks user init
        }
      },
      cmd = {
        home .. "/.local/bin/lua-language-server",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      -- Make the server aware of Neovim runtime files
      -- also include user defined files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          home .. "/.luarocks/share/lua/5.1"
        },
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

-- gutter signs for LSP errors
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = 'x' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '»' })

-- display diagnostics for LSP errors
vim.diagnostic.config({
  virtual_text = false, -- change this to enable inline errors
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})
