local M = {}

function M.setup()
  -- builtin commenting (gc / gcc), see :help commenting

  -- Linewise toggle current line using C-/
  vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })

  -- Linewise toggle selection using C-/
  vim.keymap.set('x', '<C-_>', 'gc', { remap = true })
end

return M
