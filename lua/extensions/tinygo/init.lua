local M = {}

function M.setup()
  require("tinygo").setup()

  -- at the current time i only own pico boards
  -- you can update this for your board (see :TinyGoTargets)
  vim.cmd("TinyGoSetTarget pico")
end

return M
