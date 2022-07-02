
-- load in snippet plugin packs (mainly just rafamadriz/friendly-snippets for now)
-- other snippets can be defined by the user
require("luasnip.loaders.from_vscode").lazy_load()

-- CMP configutation
vim.opt.completeopt:remove("noinsert")
vim.opt.completeopt:remove("menuone")
vim.opt.completeopt:append("preview") -- Doesn't reliably close

local cmp = require'cmp'
local luasnip = require'luasnip'

-- changes the behaviour about the completion popups
-- see :help completeopt
vim.o.completeopt="menu,menuone,noselect"

-- util function for tabbing through nvim-cmp suggestions
-- taken from https://github.com/GabrieleStulzer/dotfiles/blob/master/.config/nvim/lua/plugins/nvim-cmp.lua
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    -- tab to go to next suggestion
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
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
  }),

  -- the different sources for completion
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- from the language server
    { name = 'luasnip' }, -- from snippets
    { name = 'buffer' }, -- from keywords in the buffer
    { name = 'nvim_lsp_signature_help' }, -- enables showing signature help
    { name = 'path' }, -- completing file paths
  })
})
