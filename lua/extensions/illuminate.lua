require('illuminate').configure({
  -- providers: provider used to get references in the buffer, ordered by priority
  providers = {
    'lsp',
    'treesitter',
  },
  -- do not highlight words in non editable buffers
  should_enable = function(bufnr) return vim.bo.modifiable and true or false end,
})
