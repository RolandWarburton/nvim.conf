-- Opts = { noremap = true, silent = true }
Map = function(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end
-- Expr = { noremap = true, silent = true, expr = true }
