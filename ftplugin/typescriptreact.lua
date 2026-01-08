if vim.fn.executable('deno') == 1 then
  vim.lsp.config('denols', {})
  vim.lsp.enable('denols')
else
  vim.notify("deno is missing from PATH", vim.log.levels.WARN)
end
