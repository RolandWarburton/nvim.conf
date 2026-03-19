local M = {}

function M.setup()
  local neogit = require 'neogit'
  neogit.setup {
    integrations = {
      diffview = true,
      telescope = true,
    }
  }
end

function M.keybindings()
  -- open git with just ":Git" command
  vim.api.nvim_create_user_command('Git', ':lua vim.api.nvim_command("Neogit")', {})
end

return M
