local M = {}

-- read the theme from config.yaml
local theme = _G.neovim_config.settings.theme
M.theme = theme or 'dark'

function M.setup()
  local theme_opts = {}

  -- set light or dark specific config
  if M.theme == 'light' then
    theme_opts = {
      transparent = true,
    }
  else
    theme_opts = {
      transparent = false,
    }
  end

  local opts = {
    italic_comments = true,
    disable_nvimtree_bg = true,
    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
      vscLineNumber = '#FFFFFF',
    },
  }

  opts = vim.tbl_deep_extend("force", opts, theme_opts)

  -- color scheme
  vim.o.background = M.theme
  local ok, vscode = pcall(require, 'vscode')
  if ok then
    vscode.setup(opts)
    require('vscode').load()
    require('theme.color').setup()
  end
end

function M.toggleTheme()
  if M.theme == "dark" then
    M.theme = "light"
  else
    M.theme = "dark"
  end
  M.setup()
end

function M.keybindings()
  vim.api.nvim_create_user_command('ToggleTheme', M.toggleTheme, {})
end

return M
