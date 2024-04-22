local cmpSettings = require('extensions.completion.cmp')


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

  local ls = require("luasnip")
  ls.config.set_config {
    history = true,
  }

  cmp.setup({
    snippet = {
      expand = function(args)
        ls.lsp_expand(args.body)
      end,
    },
    -- define how windows should look
    window = cmpSettings.window,
    -- key binds for nvim-cmp
    mapping = cmp.mapping.preset.insert(cmpSettings.mapping),
    -- the different sources for completion
    sources = cmp.config.sources(cmpSettings.sources)
  })
  -- load in snippet plugin packs (mainly just rafamadriz/friendly-snippets for now)
  -- other snippets can be defined by the user
  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
