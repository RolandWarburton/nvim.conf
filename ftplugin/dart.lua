local function ensure_dartls_installed()
  if vim.fn.executable('dart') == 1 then return end
  vim.notify("dart not found in PATH — install the Flutter/Dart SDK", vim.log.levels.WARN)
end

ensure_dartls_installed()
if vim.fn.executable('dart') == 1 then
  vim.lsp.config('dartls', {
    cmd = { 'dart', 'language-server', '--protocol=lsp' },
  })
  vim.lsp.enable('dartls')
else
  vim.notify("dartls is unavailable (dart missing from PATH)", vim.log.levels.WARN)
end
