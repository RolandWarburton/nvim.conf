local dap = require("dap")
local dapUI = require('debugging.dap-ui-config')
local dapKeybinds = require('debugging.dap-keybindings')
local dapVirtualText = require('debugging.dap-virtual-text')

--
-- load language configurations
--
-- Load Go configuration
local go_config = require("debugging.dap-configs.go")
dap.adapters.delve = go_config.adapter
dap.configurations.go = go_config.configurations

--
-- load misc dap configuration
--
-- setup keybindings
dapKeybinds.setup()
-- setup dap ui
dapUI.setup()
dapVirtualText.setup()
