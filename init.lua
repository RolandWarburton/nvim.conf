local home = require 'os'.getenv('HOME')

-- color scheme
vim.o.background = 'dark'
local ok, vscode = pcall(require, 'vscode')
if ok then
  vscode.setup({
    transparent = false,
    italic_comments = true,
    disable_nvimtree_bg = true,
    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
      vscLineNumber = '#FFFFFF',
    },
  })
  require('vscode').load()
end

local ini = require 'inifile'
local config = ini.parse(home .. '/.config/nvim/config.ini')['config']

require('plugins')
require('core.settings')
require('keybindings.general')
require('lsp.lsp')
require('globals.globals')
require('documentation.loadDocumentation')
require('extensions.autopairs')
require('extensions.comment')
require('extensions.comment-highlight')
require('extensions.completion')
require('extensions.dap')
require('extensions.gitsigns')
require('extensions.hydra')
require('extensions.leap')
require('extensions.lspSignature')
require('extensions.neoclip')
require('extensions.illuminate')
require('extensions.neogit')
require('extensions.null-ls')
require('extensions.nvimTree')
require('extensions.surround')
require('extensions.telescope')
require('extensions.treesitter')
require('extensions.treesitter-context')
require('extensions.venn')
require('extensions.nvimTmuxNavigation')
