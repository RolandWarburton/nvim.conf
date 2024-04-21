local home = require 'os'.getenv('HOME')

local ini = require 'inifile'
local config = ini.parse(home .. '/.config/nvim/config.ini')['config']

require('theme').setup()
require('plugins')
require('core.settings')
require('keybindings.general')
require('lsp.lsp')
require('globals.globals')
require('documentation.loadDocumentation')
require('extensions')
require('debugging.dap')
