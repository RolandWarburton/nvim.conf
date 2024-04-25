local M = {}

function M.setup()
  require('twilight').setup({
    treesitter = true,
    exclude = { 'md' }
  })
end

function M.keybindings()
  -- toggle twilight
  Map('n', '<leader>z', ':Twilight<cr>')
end

return M
