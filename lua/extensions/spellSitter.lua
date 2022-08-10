require('spellsitter').setup({
  highlight = {
    enable = true
  }
})

local spellsitter_augroup = vim.api.nvim_create_augroup("spellsitter_augroup", { clear = true })

-- disable spellchecking for markdown
-- You can determine the file type using the `:echo &filetype` command
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NeogitStatus" },
  command = "setlocal nospell",
  group = spellsitter_augroup,
})

-- disable spellchecking in the embeded terminal
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nospell",
  group = spellsitter_augroup,
})
