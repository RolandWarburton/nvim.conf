-- use for EOL and SPACE
vim.cmd('hi Nontext ctermfg=\'Gray\'')

-- use for the column ruler
vim.cmd('hi ColorColumn ctermbg=\'Gray\'')

-- use for EOL, space
vim.highlight.create("SpecialKey", { ctermbg = "Gray", ctermfg = 07 })

vim.opt.termguicolors = true

-- vim lsp error and warning inline text
vim.highlight.create("DiagnosticVirtualTextError", { guifg = '#ff0000' })

-- color the tabs
vim.highlight.create("TabLineSel", { gui = 'none', cterm = 'none', guifg='#D4D4D4', guibg='#9D6BCD'})
vim.highlight.create("TabLine", { cterm = 'none', guifg='#808080', gui = 'none', guibg='#1E1E1E'})
vim.highlight.create("TabLineFill", { guibg = '#1E1E1E', guifg='#1E1E1E'})
vim.highlight.create("Title", { gui='none', cterm='none', guibg = 'none', guifg='#D4D4D4'})

-- the active status line
vim.highlight.create("StatusLine", { guifg = '#9D6BCD' })

-- the inactive status line
vim.highlight.create("StatusLineNC", { guifg = '#848484' })

-- Apply the basic terminal colors for the theme
-- there are 15 colors, plus "terminal_color_foreground" and "terminal_color_background"
vim.g.terminal_color_4 = '#569CD6'
