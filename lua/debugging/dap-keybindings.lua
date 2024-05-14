local function setup()
  local Hydra = require('hydra')
  Hydra({
    name = "Debugging",
    hint = [[
    _K_ Hover
    _o_ Toggle Breakpoint
    _d_ Start Debugging
    _t_ Stop Debugging
    _r_ heads Debugging
    _s_ Step Over
    _i_ Step Into
    _p_ Step Out
    _c_ Continue
    _n_ Open Debugger
    _q_ Close Debugger
    ]],
    config = {
      color = 'pink',
      invoke_on_body = true,
      hint = {
        border = 'rounded'
      },
    },
    mode = 'n',
    body = '<leader>x',
    heads = {
      { 'K',     function() require('dap.ui.widgets').hover() end },
      { 'o',     function() require('dap').toggle_breakpoint() end },
      { 'd',     function() require('dap').continue() end },
      { 't',     function() require('dap').close() end },
      { 'r',     function() require('dap').restart() end },
      { 's',     function() require('dap').step_over() end },
      { 'i',     function() require('dap').step_into() end },
      { 'p',     function() require('dap').step_out() end },
      { 'c',     function() require('dap').continue() end },
      { 'q',     function() require('dapui').close() end },
      { 'n',     function() require('dapui').open() end },
      { '<Esc>', nil,                                              { exit = true } },
    }
  })
end

return {
  setup = setup
}
