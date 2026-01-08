if vim.fn.executable('lua-language-server') == 1 then
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            vim.fn.stdpath("config") .. "/lua",
            vim.fn.expand("$HOME/.local/share/luarocks/share/lua/5.1"),
          },
        },
        telemetry = { enable = false },
      },
    },
  })
  vim.lsp.enable('lua_ls')
else
  vim.notify("lua-language-server is missing from PATH", vim.log.levels.WARN)
end
