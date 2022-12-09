local M = {}

-- method two
Listchars = {
  nbsp = "+",
  space = "·",
  tab = "> ",
  trail = "#"
}

function M.setup()
  -- this is the same as `set list`
  vim.opt.list = true
  vim.opt.listchars:append(Listchars)
end

return M
