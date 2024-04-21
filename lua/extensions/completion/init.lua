local cmpSettings = require('extensions.completion.cmp')

-- load in snippet plugin packs (mainly just rafamadriz/friendly-snippets for now)
-- other snippets can be defined by the user
local luasnip = require("luasnip.loaders.from_vscode")
luasnip.lazy_load()

local M = {}

-- changes the behavior about the completion pop ups
-- see :help completeopt
vim.o.completeopt = "menu,menuone,noselect"

function M.setup()
  local cmp = require('cmp')
  if cmp == nil then
    vim.api.nvim_err_writeln('CMP failed to load')
    return
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    -- define how windows should look
    window = cmpSettings.window,
    -- key binds for nvim-cmp
    mapping = cmp.mapping.preset.insert(cmpSettings.mapping),
    -- the different sources for completion
    sources = cmp.config.sources(cmpSettings.sources)
  })
end

return M
