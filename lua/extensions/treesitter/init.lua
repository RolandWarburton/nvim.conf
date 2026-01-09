-- to install new TS language support
-- :TSInstall typescript
local M = {}

local treesitter = require('extensions.treesitter.treesitter')
local treesitterContext = require('extensions.treesitter.treesitter-context')
local rainbow = require('extensions.treesitter.rainbow')

function M.setup()
  treesitter.setup()
  treesitterContext.setup()
  rainbow.setup()
end

return M
