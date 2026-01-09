local M = {}

local function telescope_find_files()
  local current_file_dir = vim.fn.expand('%:p:h')
  local cmd = string.format("git -C %s rev-parse --show-toplevel", vim.fn.shellescape(current_file_dir))
  local git_root = vim.fn.systemlist(cmd)[1]

  local opts = {
    hidden = true,     -- show hidden files
    no_ignore = false, -- show .gitignore files
  }

  -- if the git command failed we are not in a git repo
  -- so telescope search from the current directory
  if vim.v.shell_error ~= 0 then
    opts.cwd = current_file_dir
    require('telescope.builtin').find_files(opts)
  else
    opts.cwd = git_root
    require('telescope.builtin').find_files(opts)
  end
end

function M.setup()
  require('telescope').setup {
    pickers = {
      find_files = {
        hidden = true
      },
      buffers = {
        mappings = {
          i = {
            ["<c-d>"] = "delete_buffer",
          }
        }
      }
    },
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
  Map('n', '<C-p>', function() telescope_find_files() end) -- careful with this on slow computers
end

return M
