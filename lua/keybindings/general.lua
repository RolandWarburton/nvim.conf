-- Modes
--   normal_mode       = "n",
--   insert_mode       = "i",
--   visual_mode       = "v",
--   visual_block_mode = "x",
--   term_mode         = "t",
--   command_mode      = "c",

require('util.helpers')
require('keybindings.util')

-- map leader key
Map("n", ",", "<Nop>")
vim.g.mapleader = ','

---------------------
-- PLUGIN KEYBINDINGS
---------------------

-- import plugin specific keybindings
require('extensions.telescope').keybindings()
require('extensions.gitsigns').keybindings()
require('extensions.neogit').keybindings()
require('extensions.nvimTree').keybindings()
require('extensions.twilight').keybindings()
require('theme').keybindings()

---------------------
-- EDITOR KEYBINDINGS
---------------------

-- "ctrl+s % and ctrl+s"
-- use a bang on Vexplore to open to the right
Map('n', '<C-s>%', ':Vexplore!<cr>')
Map('n', '<C-s>"', ':Hexplore<cr>')

-- turn highlighting off
Map('n', '<C-n>', ':noh<cr>')

-- tab navigation
Map('n', '<C-PageUp>', ':tabn<cr>')
Map('n', '<C-PageDown>', ':tabp<cr>')

-- paste from the system clipboard
-- note system clipboard copy is done in :h clipboard
Map('n', 'p', '"+p')

-- tab navigation
Map('n', '<Leader>t', ':tabnew<cr>')
Map('n', '<Leader>1', '1gt')
Map('n', '<Leader>2', '2gt')
Map('n', '<Leader>3', '3gt')
Map('n', '<Leader>4', '4gt')
Map('n', '<Leader>5', '5gt')
Map('n', '<Leader>6', '6gt')
Map('n', '<Leader>7', '7gt')
Map('n', '<Leader>8', '8gt')
Map('n', '<Leader>9', '9gt')

-- create a "quit all" alias
Map('n', '<Leader>qq', ':qa!<cr>')

----------------
-- USER COMMANDS
----------------

-- create a custom command to toggle format on save
vim.api.nvim_create_user_command('ToggleFormatOnSave', ':lua Toggle_format_on_save()<cr>', {})

-- create a custom command to open the diagnostic window
vim.api.nvim_create_user_command('Diagnostics', ':lua vim.diagnostic.setloclist()<cr>', {})

vim.api.nvim_create_user_command('ToggleSpaceVirtText', ':lua Toggle_listchar()<cr>', {})

-- copy buffer to clipboard
vim.api.nvim_create_user_command('CopyBufferToClipboard', ':lua CopyBufferToClipboard()<cr>', {})

-- insert todays date
vim.api.nvim_create_user_command('InsertDate', ':lua InsertDate(false)<cr>', {})
vim.api.nvim_create_user_command('InsertDateTime', ':lua InsertDate(true)<cr>', {})

-- Set the keybinding to go to the last window ID
vim.keymap.set('n', '<Leader>w', ':lua Go_to_last_window()<cr>')
