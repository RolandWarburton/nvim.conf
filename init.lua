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

local function loadPlugin(name)
  ok, err = pcall(require, name)
  if (not ok) then
    print("failed to load " .. name)
  end
  if (not os.getenv("LOAD_PLUGIN_FAILS_SILENTLY") == "true")  then
    print(err)
  end
end

loadPlugin('plugins')
require('core.settings')
require('core.listchars').setup()
loadPlugin('keybindings.general')
loadPlugin('keybindings.comment')
loadPlugin('lsp.lsp')
loadPlugin('neovide.config')
loadPlugin('core.statusline')
loadPlugin('globals.globals')
loadPlugin('documentation.loadDocumentation')
loadPlugin('extensions.autopairs')
loadPlugin('extensions.comment')
loadPlugin('extensions.comment-highlight')
loadPlugin('extensions.completion')
loadPlugin('extensions.gitsigns')
loadPlugin('extensions.hydra')
loadPlugin('extensions.lspSignature')
loadPlugin('extensions.neoclip')
loadPlugin('extensions.neogit')
if config['enable_presence'] then
  loadPlugin('extensions.presence')
end
loadPlugin('extensions.null-ls')
loadPlugin('extensions.nvimTree')
loadPlugin('extensions.spellSitter')
loadPlugin('extensions.surround')
loadPlugin('extensions.telescope')
loadPlugin('extensions.treesitter')
loadPlugin('extensions.treesitter-context')
loadPlugin('extensions.venn')
loadPlugin('core.color')
require('core.tabline').setup()
