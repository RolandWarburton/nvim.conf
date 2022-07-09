local M = {}

-- This is unbearably slow, caused by a flaw with neovim
-- config taken from: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor=
-- https://github.com/neovim/neovim/issues/12587
function M.lsp_highlight_under_cursor(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      " hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi! LspReferenceRead cterm=bold ctermbg=red guibg=#303030
      hi! LspReferenceText cterm=bold ctermbg=red guibg=#303030
      hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#303030
    ]]
    vim.api.nvim_create_augroup('lsp_document_highlight', {
      clear = false
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = 'lsp_document_highlight',
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
