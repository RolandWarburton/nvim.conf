local M = {}

function M.setup()
  vim.opt.list = true
  vim.opt.listchars = {
    tab = "> ",
    trail = "#",
    space = "·",
    nbsp = "░"
  }
end

return M
