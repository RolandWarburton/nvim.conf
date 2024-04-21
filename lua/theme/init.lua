local M = {}

function M.setup()
  -- color scheme
  vim.o.background = 'dark'
  local ok, vscode = pcall(require, 'vscode')
  if ok then
    vscode.setup({
      transparent = false,
      italic_comments = true,
      disable_nvimtree_bg = true,
      -- Override colors (see ./lua/vscode/colors.lua)
      color_overrides = {
        vscLineNumber = '#FFFFFF',
      },
    })
    require('vscode').load()
  end
end

return M
