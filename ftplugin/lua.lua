local function ensure_lua_ls_installed()
  if vim.fn.executable('lua-language-server') == 1 then return end
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    vim.notify("lua-language-server not in PATH and Mason not available", vim.log.levels.WARN)
    return
  end
  local pkg = registry.get_package('lua-language-server')
  if not pkg:is_installed() then
    vim.notify("Installing lua-language-server via Mason...", vim.log.levels.INFO)
    pkg:install()
  end
end

ensure_lua_ls_installed()
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
