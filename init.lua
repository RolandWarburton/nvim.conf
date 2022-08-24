-- color scheme
local ok, vscode = pcall(require, 'vscode')
if ok then
  vscode.setup({
    transparent = false,
  })
end

require('core.settings')
require('core.trailing')
require('core.space')
require('keybindings.general')
require('keybindings.comment')
require('plugins')
require('lsp.lsp')
require('neovide.config')
require('core.statusline')
require('globals.globals')
require('documentation.loadDocumentation')
require('extensions.autopairs')
require('extensions.comment')
require('extensions.completion')
require('extensions.gitsigns')
require('extensions.lspSignature')
require('extensions.neoclip')
require('extensions.neogit')
require('extensions.presence')
require('extensions.null-ls')
require('extensions.nvimTree')
require('extensions.spellSitter')
require('extensions.telescope')
require('extensions.treesitter')
require('core.color')
require('core.tabline').setup()
