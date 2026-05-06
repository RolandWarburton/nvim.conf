local M = {}

function M.setup()
  -- manually set the filetype
  -- and treesitter parser for caddy files
  vim.filetype.add({
    filename = { ['caddyfile'] = 'caddyfile' },
    pattern = { ['.*/caddyfile'] = 'caddyfile' },
  })
end

return M
