local M = {}

Listchars = {
  tab = "> ",
  trail = "#",
  space = "·",
  nbsp = "░"
}

function M.setup()
  vim.opt.list = true
  vim.opt.listchars = Listchars
end

return M
