-- to install new TS language support
-- :TSUpdateSync
-- :TSInstall typescript
local M = {}

local treesitter = require('extensions.treesitter.treesitter')
local treesitterContext = require('extensions.treesitter.treesitter-context')

function M.setup()
  treesitter.setup()
  treesitterContext.setup()
end

return M
