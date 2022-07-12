-- SHOW SPACES

-- method one
-- vim.api.nvim_set_hl(0, "Spaces", { default = true, fg = "#ff0000", bg = "#ff0000" })
-- vim.cmd([[match TrailingSpaces /\s/]])

-- method two

-- this is the same as `set list`
vim.opt.list = true
vim.cmd('set listchars+=space:·')

-- this fixes trailing spaces from being
vim.cmd([[set listchars+=trail:\ ]])

