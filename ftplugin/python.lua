if vim.fn.executable('pyright') == 1 then
  vim.lsp.config('pyright', {})
  vim.lsp.enable('pyright')
else
  vim.notify("pyright is missing from PATH", vim.log.levels.WARN)
end
