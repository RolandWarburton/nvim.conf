local M = {}

function M.setup()
  require('telescope').setup {
    defaults = {
      file_ignore_patterns = { "node_modules", ".git/" },
    },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      }
    }
  }

  -- To get fzf loaded and working with telescope, you need to call load_extension('fzf')
  require('telescope').load_extension('fzf')
end

function M.keybindings()
  -- open command history
  -- requires neoclip, and telescope
  Map('n', '<Leader>c', ':Telescope neoclip<cr>')

  -- open last telescope command, preserving state
  Map('n', '<Leader>r', ':Telescope resume<cr>')

  -- live grep
  Map('n', '<Leader>g', ':Telescope live_grep<cr>')

  -- fuzzy find vim commands
  Map('n', '<Leader>p', ':Telescope commands<cr>')

  -- fuzzy find buffers
  Map('n', '<Leader>b', ':Telescope buffers<cr>')

  -- map telescope fzf to appropriate ctrl+p to find files
  local isInGit = os.execute('git rev-parse --is-inside-work-tree')
  if isInGit == "true" then
    Map('n', '<C-p>', ':Telescope git_files<cr>')
  else
    Map('n', '<C-p>', ':Telescope find_files hidden=true <cr>') -- careful with this on slow computers
  end
end

return M
