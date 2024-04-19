local dap = require("dap")
local dapUI = require('dap-ui-config')
local dapKeybinds = require('dap-keybindings')

--
-- load language configurations
--
-- Load Go configuration
local go_config = require("dap-configs.go")
dap.adapters.delve = go_config.adapter
dap.configurations.go = go_config.configurations

--
-- load misc dap configuration
--
-- setup keybindings
dapKeybinds.setup()
-- setup dap ui
dapUI.setup()
