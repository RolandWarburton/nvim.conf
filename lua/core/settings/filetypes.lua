local M = {}

function M.setup()
  -- manually set the filetype
  -- and treesitter parser for caddy files
  vim.filetype.add({
    filename = { ['caddyfile'] = 'caddyfile' },
    pattern = { ['.*/caddyfile'] = 'caddyfile' },
  })

  -- manually set the filetype
  -- and treesitter parser for systemd files
  -- .service, .socket, .timer, etc
  vim.treesitter.language.register('ini', 'systemd')
  vim.filetype.add({
    extension = {
      service = 'systemd',
      socket = 'systemd',
      timer = 'systemd',
      mount = 'systemd',
      target = 'systemd',
      path = 'systemd',
      slice = 'systemd',
      scope = 'systemd',
      swap = 'systemd',
      automount = 'systemd',
      device = 'systemd',
      nspawn = 'systemd',
      link = 'systemd',
      netdev = 'systemd',
      network = 'systemd',
    },
    pattern = {
      ['.*/systemd/.*'] = 'systemd',
    },
  })
end

return M
