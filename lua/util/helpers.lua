-- see help :map-arguments for more possible arguments
-- some common opts include `Opts = { noremap = true, silent = true }`
-- lhs = actions
-- rhs = command
--
-- EXAMPLES
-- Map('n', '<Leader>t', ':tabnew<cr>') leader, t
-- Map('n', '<C-n>', ':noh<cr>') control + n
Map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end
