-----------------------------
-- SELECT LAST WINDOW FEATURE
-----------------------------

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

----------------------
-- INSERT DATE FEATURE
----------------------

function InsertDate(withTime)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if (withTime) then
    vim.api.nvim_buf_set_text(
      0, row - 1, col, row - 1, col,
      { os.date('%Y-%m-%d %I:%M %p') }
    )
  else
    vim.api.nvim_buf_set_text(
      0, row - 1, col, row - 1, col,
      { os.date('%Y-%m-%d') }
    )
  end
end

-------------------------------
-- TOGGLE VIRTUAL SPACE FEATURE
-------------------------------

-- toggle the space virtual text
function Toggle_listchar()
  local listchars = vim.opt.listchars:get()
  if listchars.space == Listchars.space then
    vim.opt.listchars:append({ space = " " })
  else
    vim.opt.listchars = Listchars
  end
end

-----------------------------------
-- COPY BUFFER TO CLIPBOARD FEATURE
-----------------------------------

function CopyBufferToClipboard()
  local content = table.concat(vim.fn.getline(1, '$'), "\n")
  content = content:gsub("'", "'\\''") -- Escape single quotes
  vim.fn.setreg('+', content, 'c')
end
