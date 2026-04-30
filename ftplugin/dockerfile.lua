local function ensure_dockerls_installed()
  if vim.fn.executable('docker-langserver') == 1 then return end
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    vim.notify("docker-langserver not in PATH and Mason not available", vim.log.levels.WARN)
    return
  end
  local ok_pkg, pkg = pcall(registry.get_package, 'dockerfile-language-server')
  if not ok_pkg then return end
  if not pkg:is_installed() then
    vim.notify("Installing dockerfile-language-server via Mason...", vim.log.levels.INFO)
    pkg:install()
  end
end

ensure_dockerls_installed()
if vim.fn.executable('docker-langserver') == 1 then
  vim.lsp.config('dockerls', {})
  vim.lsp.enable('dockerls')
else
  vim.notify("docker-langserver is missing from PATH", vim.log.levels.WARN)
end
