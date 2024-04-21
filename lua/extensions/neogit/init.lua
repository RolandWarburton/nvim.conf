local M = {}

function M.setup()
  local neogit = require 'neogit'
  neogit.setup {
    intergrations = {
      diffview = true
    }
  }
end

return M
