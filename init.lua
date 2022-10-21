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

require('plugins')
pcall(require, 'core.settings')
pcall(require, 'core.trailing')
pcall(require, 'core.space')
pcall(require, 'keybindings.general')
pcall(require, 'keybindings.comment')
pcall(require, 'lsp.lsp')
pcall(require, 'neovide.config')
pcall(require, 'core.statusline')
pcall(require, 'globals.globals')
pcall(require, 'documentation.loadDocumentation')
pcall(require, 'extensions.autopairs')
pcall(require, 'extensions.comment')
pcall(require, 'extensions.comment-highlight')
pcall(require, 'extensions.completion')
pcall(require, 'extensions.gitsigns')
pcall(require, 'extensions.hydra')
pcall(require, 'extensions.lspSignature')
pcall(require, 'extensions.neoclip')
pcall(require, 'extensions.neogit')
if config['enable_presence'] then
  pcall(require, 'extensions.presence')
end
pcall(require, 'extensions.null-ls')
pcall(require, 'extensions.nvimTree')
pcall(require, 'extensions.spellSitter')
pcall(require, 'extensions.surround')
pcall(require, 'extensions.telescope')
pcall(require, 'extensions.treesitter')
pcall(require, 'extensions.treesitter-context')
pcall(require, 'extensions.venn')
pcall(require, 'core.color')
require('core.tabline').setup()
