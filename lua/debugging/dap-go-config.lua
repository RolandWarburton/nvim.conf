local function setup()
  local dapgo = require('dap-go-config')
  dapgo.setup()
end

return {
  setup = setup
}
