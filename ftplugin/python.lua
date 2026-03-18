local function ensure_pyright_installed()
  if vim.fn.executable('pyright') == 1 then return end
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    vim.notify("pyright not in PATH and Mason not available", vim.log.levels.WARN)
    return
  end
  local pkg = registry.get_package('pyright')
  if not pkg:is_installed() then
    vim.notify("Installing pyright via Mason...", vim.log.levels.INFO)
    pkg:install()
  end
end

ensure_pyright_installed()
if vim.fn.executable('pyright') == 1 then
  vim.lsp.config('pyright', {})
  vim.lsp.enable('pyright')
else
  vim.notify("pyright is missing from PATH", vim.log.levels.WARN)
end
