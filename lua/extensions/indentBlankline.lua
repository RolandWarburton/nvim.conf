vim.opt.list = true -- show all white space as a char
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("tab:  ")

vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", {default = false, fg = "#565575"})

-- these exist for when i figure out how to have rainbow indent guides
vim.api.nvim_set_hl(0, "IndentBlankLineIndent0", {default = false, fg = "#565575"})
vim.api.nvim_set_hl(0, "IndentBlankLineIndent1", {default = false, fg = "#EAC502"})
vim.api.nvim_set_hl(0, "IndentBlankLineIndent2", {default = false, fg = "#DA70D6"})
vim.api.nvim_set_hl(0, "IndentBlankLineIndent3", {default = false, fg = "#179CFB"})

require("indent_blankline").setup({
  space_char_blankline = " ",
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = false,
  space_char_highlight_list = {
    "IndentBlanklineIndent0",
  },
})
