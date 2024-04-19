local function setup()
  local n = "n"
  vim.keymap.set(n, '<space>dk', function() require('dap').continue() end)
  vim.keymap.set(n, '<space>dl', function() require('dap').run_last() end)
  vim.keymap.set(n, '<space>db', function() require('dap').toggle_breakpoint() end)
end

return {
  setup = setup
}
