local has_package_json = vim.fs.find('package.json', {
  upward = true,
  path = vim.fn.expand('%:p:h'),
  stop = vim.env.HOME,
})[1] ~= nil

-- use ts_ls (typescript-language-server) if package.json exists
if has_package_json then
  vim.lsp.config('ts_ls', {})
  vim.lsp.enable('ts_ls')
elseif vim.fn.executable('deno') == 1 then
  vim.lsp.config('denols', {})
  vim.lsp.enable('denols')
else
  vim.notify("No TypeScript LSP available", vim.log.levels.WARN)
end
