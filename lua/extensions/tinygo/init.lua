local M = {}

-- TinyGo is a compiler for microncontrollers
-- This neovim package tinygo.nvim allows for LSP like auto complete
-- as well as a definition for the `machine` object (which is a pico board in my case)
-- Documentation:
-- https://tinygo.org/docs/guides/ide-integration/vim-neovim/

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
