local home = require'os'.getenv('HOME')

-- color scheme
local ok, vscode = pcall(require, 'vscode')
if ok then
  vscode.setup({
    transparent = false,
  })
end

local ini = require 'inifile'
local config = ini.parse(home .. '/.config/nvim/config.ini')['config']

require('core.settings')
require('core.trailing')
-- require('core.space')
require('keybindings.general')
require('keybindings.comment')
require('plugins')
require('lsp.lsp')
require('neovide.config')
require('core.statusline')
require('globals.globals')
require('documentation.loadDocumentation')
require('extensions.autopairs')
require('extensions.indentBlankline')
require('extensions.comment')
require('extensions.comment-highlight')
require('extensions.completion')
require('extensions.dapui')
require('extensions.gitsigns')
require('extensions.hydra')
require('extensions.lspSignature')
require('extensions.neoclip')
require('extensions.neogit')
if config['enable_presence'] then
  require('extensions.presence')
end
require('extensions.null-ls')
require('extensions.nvimDap')
require('extensions.nvimTree')
require('extensions.spellSitter')
require('extensions.surround')
require('extensions.telescope')
require('extensions.treesitter')
require('extensions.treesitter-context')
require('extensions.venn')
require('core.color')
require('core.tabline').setup()
