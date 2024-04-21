local M = {}

function M.setup()
  require 'Comment'.setup {}

  -- commenting api from comment.nvim
  -- https://github.com/numToStr/Comment.nvim/blob/master/doc/API.md

  -- Linewise toggle current line using C-/
  vim.keymap.set('n', '<C-_>', ':lua require("Comment.api").toggle.linewise.current()<CR>')

  -- Linewise toggle using C-/
  vim.keymap.set('x', '<C-_>', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

  -- Blockwise toggle using <leader>gb
  vim.keymap.set('x', '<leader>gb', '<ESC><CMD>lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())<CR>')
end

return M
