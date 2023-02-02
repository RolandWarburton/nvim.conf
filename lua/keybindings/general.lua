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
if isInGit == "true"then
  map('n', '<C-p>', ':Telescope git_files<cr>')
else
  map('n', '<C-p>', ':Telescope find_files hidden=true <cr>') -- careful with this on slow computers
end

-- fuzzy find vim commands
map('n', '<Leader>p', ':Telescope commands<cr>')

-- mimic "Find active file in file explorer" in VSCode
function _G.revealFileJump()
  -- if currently on the nvim tree window
  if string.find(vim.api.nvim_buf_get_name(0), 'NvimTree')  then
    -- move cursor back to the previous window
    local key = vim.api.nvim_replace_termcodes("<C-w>p", true, false, true)
    vim.api.nvim_feedkeys(key, 'n', false)
  else
    -- show or move the cursor to the file in the file tree
    -- check if a file is open (will be an empty string if no file is open)
    if vim.fn.expand('%') == '' then
      vim.cmd('NvimTreeOpen')
    else
      vim.cmd('NvimTreeFindFile')
      -- set a custom name for the tree window
      vim.api.nvim_set_option_value('statusline', 'NvimTree', {scope = 'local'})
    end
  end
end

-- map F1 to jump to file tree
map('n', '<F1>', ':lua revealFileJump()<cr>')

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
map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<cr>')
map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<cr>')
map('n', '<leader>hu', ':Gitsigns undo_stage_hunk<cr>')
map('n', '<leader>hd', ':Gitsigns diffthis<cr>')
map('n', '<leader>td', ':Gitsigns toggle_deleted<cr>')

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
