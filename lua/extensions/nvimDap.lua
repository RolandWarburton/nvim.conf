local dap = require('dap');

dap.set_log_level('TRACE');

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {
    "/home/roland/.local/debug/vscode-node-debug2/out/src/nodeDebug.js",
  },
}

dap.configurations.javascript = {
  -- this doesn't work that great
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    outFiles = {"${workspaceFolder}/dist/**/*.js"},
  },
  -- this works at the moment if you manually start the built javascript
  -- For this to work you need to make sure the node process is started with the `--inspect` flag.
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

dap.configurations.typescript = dap.configurations.javascript
