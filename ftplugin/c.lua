local function ensure_clangd_installed()
  if vim.fn.executable('clangd') == 1 then return end
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    vim.notify("clangd not in PATH and Mason not available", vim.log.levels.WARN)
    return
  end
  local ok_pkg, pkg = pcall(registry.get_package, 'clangd')
  if not ok_pkg then return end
  if not pkg:is_installed() then
    vim.notify("Installing clangd via Mason...", vim.log.levels.INFO)
    pkg:install()
  end
end

ensure_clangd_installed()
if vim.fn.executable('clangd') == 1 then
  vim.lsp.config('clangd', {})
  vim.lsp.enable('clangd')
else
  vim.notify("clangd is missing from PATH", vim.log.levels.WARN)
end
