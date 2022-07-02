-- commenting api from comment.nvim
-- https://github.com/numToStr/Comment.nvim/blob/master/doc/API.md

-- Linewise toggle current line using C-/
vim.keymap.set('n', '<C-_>', ':lua require("Comment.api").toggle_current_linewise()<CR>')
-- map('n', 'C-_', ':lua ToggleComment()<cr>' )

-- Linewise toggle using C-/
vim.keymap.set('x', '<C-_>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- Blockwise toggle using <leader>gb
vim.keymap.set('x', '<leader>gb', '<ESC><CMD>lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())<CR>')
