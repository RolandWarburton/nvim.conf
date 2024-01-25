-- store some useful util helpers
-- local currentFile = vim.cmd("echo expand('%:p')")

-- Modes
--   normal_mode       = "n",
--   insert_mode       = "i",
--   visual_mode       = "v",
--   visual_block_mode = "x",
--   term_mode         = "t",
--   command_mode      = "c",

-- some shortcuts to make the conf file more clean
local opts = { noremap = true, silent = true }
local function map(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end
local expr = { noremap = true, silent = true, expr = true }

-- map leader key
map("n", ",", "<Nop>")
vim.g.mapleader = ','

-- "ctrl+s % and ctrl+s"
-- use a bang on Vexplore to open to the right
map('n', '<C-s>%', ':Vexplore!<cr>')
map('n', '<C-s>"', ':Hexplore<cr>')

-- turn highlighting off
map('n', '<C-n>', ':noh<cr>')

-- tab navigation
map('n', '<C-PageUp>', ':tabn<cr>')
map('n', '<C-PageDown>', ':tabp<cr>')

-- paste from the system clipboard
-- note system clipboard copy is done in :h clipboard
map('n', 'p', '"+p')
-- map telescope fzf to appropriate ctrl+p to find files
local isInGit = os.execute('git rev-parse --is-inside-work-tree')
if isInGit == "true" then
  map('n', '<C-p>', ':Telescope git_files<cr>')
else
  map('n', '<C-p>', ':Telescope find_files hidden=true <cr>') -- careful with this on slow computers
end

-- fuzzy find vim commands
map('n', '<Leader>p', ':Telescope commands<cr>')

-- tab navigation
map('n', '<Leader>t', ':tabnew<cr>')
map('n', '<Leader>1', '1gt')
map('n', '<Leader>2', '2gt')
map('n', '<Leader>3', '3gt')
map('n', '<Leader>4', '4gt')
map('n', '<Leader>5', '5gt')
map('n', '<Leader>6', '6gt')
map('n', '<Leader>7', '7gt')
map('n', '<Leader>8', '8gt')
map('n', '<Leader>9', '9gt')

-- open command history
-- requires neoclip, and telescope
map('n', '<Leader>c', ':Telescope neoclip<cr>')

-- open last telescope command, preserving state
map('n', '<Leader>r', ':Telescope resume<cr>')

-- live grep
map('n', '<Leader>g', ':Telescope live_grep<cr>')

-- open git with just ":Git" command
vim.api.nvim_create_user_command('Git', ':lua vim.api.nvim_command("Neogit")', {})

-- create a custom command to "format the file"
-- vim.api.nvim_create_user_command('FormatFile', ':lua vim.lsp.buf.formatting()<cr>', {})
vim.api.nvim_create_user_command('FormatFile', ':lua Lsp_formatting()<cr>', {})

-- create a custom command to toggle format on save
vim.api.nvim_create_user_command('ToggleFormatOnSave', ':lua Toggle_format_on_save()<cr>', {})

-- create a custom command to rename symbols
vim.api.nvim_create_user_command('RenameSymbol', ':lua vim.lsp.buf.rename()<cr>', {})

-- create a qa! alias
map('n', '<Leader>qq', ':qa<cr>')

-- git blame via gitsigns.nvim plugin
map('n', '<space>gb', ':Gitsigns blame_line<cr>')

-- git toggle to show deleted lines
vim.api.nvim_create_user_command('GitToggleShowDeletedLines', ':Gitsigns toggle_deleted<cr>', {})

-- git open diff for the current file
vim.api.nvim_create_user_command('GitOpenDiff', ':Gitsigns diffthis<cr>', {})

-- create a custom command to open the diagnostic window
vim.api.nvim_create_user_command('Diagnostics', ':lua vim.diagnostic.setloclist()<cr>', {})

-- nvim tree find file
map('n', '<Leader>f', ':NvimTreeFindFile<cr>')

-- create jump to next and previous git hunk
map('n', ']c', ':Gitsigns next_hunk<cr>')
map('n', '[c', ':Gitsigns prev_hunk<cr>')
map('v', ']c', ':Gitsigns select_hunk<cr>')
map('v', '[c', ':Gitsigns select_hunk<cr>')
map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<cr>')
map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<cr>')
map('n', '<leader>hu', ':Gitsigns undo_stage_hunk<cr>')
map('n', '<leader>hd', ':Gitsigns diffthis<cr>')
map('n', '<leader>td', ':Gitsigns toggle_deleted<cr>')

-- toggle twilight
map('n', '<leader>z', ':Twilight<cr>')

-- toggle the space virtual text
function Toggle_listchar()
  local listchars = vim.opt.listchars:get()
  print(listchars)
  if listchars.space == Listchars.space then
    vim.opt.listchars:append({ space = " " })
  else
    vim.opt.listchars:append({ space = Listchars.space })
  end
end

vim.api.nvim_create_user_command('ToggleSpaceVirtText', ':lua Toggle_listchar()<cr>', {})

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

function CopyBufferToClipboard()
  local content = table.concat(vim.fn.getline(1, '$'), "\n")
  content = content:gsub("'", "'\\''") -- Escape single quotes
  vim.fn.setreg('+', content, 'c')
end

vim.api.nvim_create_user_command('CopyBufferToClipboard', ':lua CopyBufferToClipboard()<cr>', {})
vim.api.nvim_create_user_command('InsertDate', ':lua InsertDate(false)<cr>', {})
vim.api.nvim_create_user_command('InsertDateTime', ':lua InsertDate(true)<cr>', {})
