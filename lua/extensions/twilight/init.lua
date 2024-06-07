local M = {}

function M.setup()
  require('twilight').setup({
    treesitter = true,
    context = 1,
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
      "function_declaration",
      "method_declaration",
      "method_signature",
      "ambient_declaration",
    },
    exclude = { 'md' }
  })
end

function M.keybindings()
  -- toggle twilight
  Map('n', '<leader>z', ':Twilight<cr>')
end

return M
