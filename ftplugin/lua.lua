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
-- vim.lsp.config('lua_ls', {})
vim.lsp.enable('lua_ls')
