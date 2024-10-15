local M = {}

function M.setup()
  require("tinygo").setup()


  local user_id = vim.loop.getuid()
  if user_id and user_id >= 1000 then
    -- at the current time i only own pico boards
    -- you can update this for your board (see :TinyGoTargets)
    vim.cmd("TinyGoSetTarget pico")
  end
end

return M
