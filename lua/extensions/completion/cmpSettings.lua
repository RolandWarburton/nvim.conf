local M = {}
local cmp = require('cmp')
local ls = require('luasnip')
local lspkind = require('lspkind')

-- util function for tabbing through nvim-cmp suggestions
-- taken from https://github.com/GabrieleStulzer/dotfiles/blob/master/.config/nvim/lua/plugins/nvim-cmp.lua
local has_words_before = function()
  ---@diagnostic disable-next-line: deprecated
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.mapping = {
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

  -- tab to go to next suggestion
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif ls.expand_or_jumpable() then
      ls.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback() -- The fallback function sends an already mapped key. In this case, it's probably `<Tab>`.
    end
  end, { "i", "s" }),

  -- shift tab to go to previous change
  ["<S-Tab>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_prev_item()
    end
  end, { "i", "s" }),
}

M.sources = {
  { name = 'nvim_lsp',                max_item_count = 48 },  -- from the language server
  { name = 'luasnip',                 max_item_count = 128 }, -- from snippets
  { name = 'buffer' },                                        -- from keywords in the buffer
  { name = 'nvim_lsp_signature_help', max_item_count = 16 },  -- enables showing signature help
  { name = 'path',                    max_item_count = 16 },  -- completing file paths
}

M.window = {
  completion = cmp.config.window.bordered(),
  documentation = cmp.config.window.bordered(),
}

M.Formatting = {
  format = lspkind.cmp_format({
    mode = "symbol_text",
    max_width = 50,
    symbol_map = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
      Copilot = "",
    }
  })
}

return M
