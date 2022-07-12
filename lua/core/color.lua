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
vim.api.nvim_set_hl(0, "TabLineSel", { default = true, fg='#D4D4D4', bg='#9D6BCD'})
vim.api.nvim_set_hl(0, "TabLine", { default = true, fg='#808080', bg='#1E1E1E'})
vim.api.nvim_set_hl(0, "TabLineFill", { default = true, bg = '#1E1E1E', fg='#1E1E1E'})
vim.api.nvim_set_hl(0, "Title", { default = true, bg = 'none', fg='#D4D4D4'})

-- the active status line
vim.api.nvim_set_hl(0, "StatusLine", { default = false, fg = '#1E1E1E', bg = '#9D6BCD' })

-- the inactive status line
vim.api.nvim_set_hl(0, "StatusLineNC", { default = false, bg = '#3E2A52', fg = '#D4D4D4' })

-- Apply the basic terminal colors for the theme
-- there are 15 colors, plus "terminal_color_foreground" and "terminal_color_background"
vim.g.terminal_color_4 = '#569CD6'

-- ray-x/lsp_signature provided highlight group for param highlighting
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { default = true, fg = '#AF5FD7' })
