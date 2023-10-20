require('illuminate').configure({
  -- do not highlight words in non editable buffers
  should_enable = function(bufnr) return vim.bo.modifiable and true or false end,
})
