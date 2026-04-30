local has_package_json = vim.fs.find('package.json', {
  upward = true,
  path = vim.fn.expand('%:p:h'),
  stop = vim.env.HOME,
})[1] ~= nil

local function ensure_ts_ls_installed()
  if vim.fn.executable('typescript-language-server') == 1 then return end
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    vim.notify("typescript-language-server not in PATH and Mason not available", vim.log.levels.WARN)
    return
  end
  local ok_pkg, pkg = pcall(registry.get_package, 'typescript-language-server')
  if not ok_pkg then return end
  if not pkg:is_installed() then
    vim.notify("Installing typescript-language-server via Mason...", vim.log.levels.INFO)
    pkg:install()
  end
end

-- use ts_ls (typescript-language-server) if package.json exists
if has_package_json then
  ensure_ts_ls_installed()
  if vim.fn.executable('typescript-language-server') == 1 then
    vim.lsp.config('ts_ls', {})
    vim.lsp.enable('ts_ls')
  else
    vim.notify("typescript-language-server is missing from PATH", vim.log.levels.WARN)
  end
elseif vim.fn.executable('deno') == 1 then
  vim.lsp.config('denols', {})
  vim.lsp.enable('denols')
else
  vim.notify("No TypeScript LSP available", vim.log.levels.WARN)
end
