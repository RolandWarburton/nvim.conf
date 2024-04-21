local M = {}

function M.setup()
  require 'lsp_signature'.setup({
    floating_window = true,
    hint_enable = false
  })
end

return M
