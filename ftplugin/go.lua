local function ensure_gopls_installed()
  if vim.fn.executable('gopls') == 1 then return end
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    vim.notify("gopls not in PATH and Mason not available", vim.log.levels.WARN)
    return
  end
  local ok_pkg, pkg = pcall(registry.get_package, 'gopls')
  if not ok_pkg then return end
  if not pkg:is_installed() then
    vim.notify("Installing gopls via Mason...", vim.log.levels.INFO)
    pkg:install()
  end
end

ensure_gopls_installed()
if vim.fn.executable('gopls') == 1 then
  vim.lsp.config('gopls', {})
  vim.lsp.enable('gopls')
else
  vim.notify("gopls is missing from PATH", vim.log.levels.WARN)
end
