-- Create a new autocommand group
local group = vim.api.nvim_create_augroup("LastWindowID", { clear = true })
local current_window_id = nil
local previous_window_id = nil

-- Define the autocommand callback function
local function print_window_id()
  local win_id = vim.api.nvim_get_current_win()
  if current_window_id then
    previous_window_id = current_window_id
  end
  current_window_id = win_id
end

-- Set the autocommand to trigger the print_window_id function on WinEnter
vim.api.nvim_create_autocmd("WinEnter", {
  group = group,
  callback = print_window_id,
})

-- Define a function to go to the last window ID
Go_to_last_window = function()
  if previous_window_id then
    pcall(vim.api.nvim_set_current_win, previous_window_id)
  end
end
