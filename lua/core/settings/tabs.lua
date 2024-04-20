local M = {}

function M.setup()
  -- SHOW TABS
  vim.opt.list = true
  vim.cmd('set list lcs=tab:»')
end

return M
