local cmp = require('cmp')
local cmpSettings = require('extensions.completion.cmpSettings')

local M = {}

-- changes the behavior about the completion pop ups
-- see :help completeopt
vim.o.completeopt = "menu,menuone,noselect"

local luasnip = require("luasnip")
luasnip.config.set_config {
  history = true,
}

-- load in snippet plugin packs (mainly just rafamadriz/friendly-snippets for now)
-- other snippets can be defined by the user
require("luasnip.loaders.from_vscode").lazy_load()
require('snippets.go')

function M.setup()
  if cmp == nil then
    vim.notify('CMP failed to load', vim.log.levels.ERROR, { title = "vim completion" })
    return
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = cmpSettings.Formatting,
    -- define how windows should look
    window = cmpSettings.window,
    -- key binds for nvim-cmp
    mapping = cmp.mapping.preset.insert(cmpSettings.mapping),
    -- the different sources for completion
    sources = cmp.config.sources(cmpSettings.sources)
  })
end

return M
