require'lsp.keybindings'
local lsp_highlight_under_cursor = require'lsp.highlightUnderCursor'.lsp_highlight_under_cursor

-- set the debug level for lsp
vim.lsp.set_log_level("debug")

-- we need this for lsp servers
local root_pattern = require("lspconfig").util.root_pattern

local lsp_config = require('lspconfig')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- this is used in on_attach to call lsp formatting when called
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
Lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  lsp_highlight_under_cursor(client, bufnr)

  -- attach the lsp_signature plugin for param help
  require'lsp_signature'.on_attach()

  -- this is a backup for seeing diagnostics if trouble is not installed
  local _, err = pcall(require, 'trouble')
  if err then
    vim.api.nvim_create_autocmd(
      { 'TextChanged', 'InsertLeave' },
      {
        pattern = '*',
        callback = function()
          -- refresh quick fix list
          vim.schedule(function() vim.diagnostic.setloclist({open = false}) end)
        end,
      }
    )
  end

  -- disable inline diagnostics
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true
    }
  )

  -- run an auto command to create keybindings
  vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})

  if client.supports_method("textDocument/formatting") then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    -- this will run before on every buffer (file) save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- check if format_on_save global is set before saving
          if vim.g.user_format_on_save then
            Lsp_formatting(bufnr)
          end
        end,
      })
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- this hooks nvim-cmp in with nvim-lsp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

---------------------------------------------------------------------------------------------------
-- TYPESCRIPT -------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- npm i -g typescript typescript-language-server eslint prettier
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver
-- https://github.com/typescript-language-server/typescript-language-server
require 'lspconfig'.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = { hostInfo = "neovim" },
  root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
}

---------------------------------------------------------------------------------------------------
-- GOLANG -----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md
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

---------------------------------------------------------------------------------------------------
-- HTML -------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- npm i -g vscode-langservers-extracted
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

---------------------------------------------------------------------------------------------------
-- LUA --------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
USER = vim.fn.expand('$USER')
local lsp_root_path = "/home/" .. USER .. "/.local/lsp"
local lua_binary_path = lsp_root_path .. "/lua-language-server/bin/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
  -- root_dir = root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml", "selene.toml", ".git", "init.lua")
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {lua_binary_path},
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = '/opt/lsp/lua-language-server/bin' },
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

