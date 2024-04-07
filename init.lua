local home = require'os'.getenv('HOME')

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
loadPlugin('core.statusline')
loadPlugin('globals.globals')
loadPlugin('documentation.loadDocumentation')
loadPlugin('extensions.autopairs')
loadPlugin('extensions.comment')
loadPlugin('extensions.comment-highlight')
loadPlugin('extensions.completion')
loadPlugin('extensions.gitsigns')
loadPlugin('extensions.hydra')
loadPlugin('extensions.leap')
loadPlugin('extensions.lspSignature')
loadPlugin('extensions.neoclip')
loadPlugin('extensions.illuminate')
loadPlugin('extensions.neogit')
if config['enable_presence'] then
  loadPlugin('extensions.presence')
end
loadPlugin('extensions.null-ls')
loadPlugin('extensions.nvimTree')
loadPlugin('extensions.surround')
loadPlugin('extensions.telescope')
loadPlugin('extensions.treesitter')
loadPlugin('extensions.treesitter-context')
loadPlugin('extensions.venn')
loadPlugin('extensions.nvimTmuxNavigation')
loadPlugin('core.color')
require('core.tabline').setup()
