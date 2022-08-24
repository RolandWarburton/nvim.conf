-- use for EOL and SPACE
vim.cmd('hi Nontext ctermfg=\'Gray\'')

-- use for the column ruler
vim.cmd('hi ColorColumn ctermbg=\'Gray\'')

-- use for EOL, space
vim.api.nvim_set_hl(0, "SpecialKey", { default = true, bg = "Gray", fg = '#ff0000' })

vim.opt.termguicolors = true

-- vim lsp error and warning inline text
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { default = true, fg = '#ff0000' })

-- color the tabs
vim.api.nvim_set_hl(0, 'TabLine', { bg = '#100e23', fg = '#565575' }) -- tab itself
vim.api.nvim_set_hl(0, 'TabLineSel', { bg = '#272638', fg = '#9D6BCD' })
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#100e23', fg = '#272638' }) -- background behind tabs
vim.api.nvim_set_hl(0, 'TabLineFillInvert', { bg = '#272638', fg = '#100e23' })
vim.api.nvim_set_hl(0, 'TabLineWarn', { bg = '#272638', fg = '#ffb378' })

-- the active status line
vim.api.nvim_set_hl(0, "StatusLine", { default = false, fg = '#1E1E1E', bg = '#9D6BCD' })

-- the inactive status line
vim.api.nvim_set_hl(0, "StatusLineNC", { default = false, bg = '#3E2A52', fg = '#D4D4D4' })

-- Apply the basic terminal colors for the theme
-- there are 15 colors, plus "terminal_color_foreground" and "terminal_color_background"
vim.g.terminal_color_4 = '#569CD6'

-- ray-x/lsp_signature provided highlight group for param highlighting
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { default = true, fg = '#AF5FD7' })

-- fix the neogit highlighting
vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", {default = false, bg = '#5F875F', fg = '#000000'})
