if vim.fn.executable('gopls') == 1 then
  vim.lsp.config('gopls', {})
  vim.lsp.enable('gopls')
else
  vim.notify("gopls is missing from PATH", vim.log.levels.WARN)
end
