if vim.fn.executable('csharp-ls') == 1 then
  vim.lsp.config('csharp_ls', {})
  vim.lsp.enable('csharp_ls')
else
  vim.notify("csharp-ls is missing from PATH", vim.log.levels.WARN)
end
