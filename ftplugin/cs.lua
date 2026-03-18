local function ensure_csharp_ls_installed()
  if vim.fn.executable('csharp-ls') == 1 then return end
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    vim.notify("csharp-ls not in PATH and Mason not available", vim.log.levels.WARN)
    return
  end
  local pkg = registry.get_package('csharp-language-server')
  if not pkg:is_installed() then
    vim.notify("Installing csharp-language-server via Mason...", vim.log.levels.INFO)
    pkg:install()
  end
end

ensure_csharp_ls_installed()
if vim.fn.executable('csharp-ls') == 1 then
  vim.lsp.config('csharp_ls', {})
  vim.lsp.enable('csharp_ls')
else
  vim.notify("csharp-ls is missing from PATH", vim.log.levels.WARN)
end
