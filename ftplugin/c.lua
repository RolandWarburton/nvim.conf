if vim.fn.executable('clangd') == 1 then
  vim.lsp.config('clangd', {})
  vim.lsp.enable('clangd')
else
  vim.notify("clangd is missing from PATH", vim.log.levels.WARN)
end
