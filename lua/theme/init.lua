local M = {}

function M.setup()
  local theme = 'dark'
  local theme_opts = {}

  -- set light or dark specific config
  if theme == 'light' then
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
  vim.o.background = theme
  local ok, vscode = pcall(require, 'vscode')
  if ok then
    vscode.setup(opts)
    require('vscode').load()
  end
end

return M
