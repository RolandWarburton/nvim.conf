local M = {}

function M.setup()
  -- tree-sitter based folding
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

  -- if a buffer has been opened for the first time its folds will be expanded
  local already_loaded_buffers = {}

  -- set up folds to persist through restarts
  -- neovim will create a "view" for a buffer when closing it, then try to load it when you oad the same buffer
  -- https://github.com/AstroNvim/AstroNvim/blob/271c9c3f71c2e315cb16c31276dec81ddca6a5a6/lua/astronvim/autocmds.lua#L98-L120
  local autocmd = vim.api.nvim_create_autocmd
  local augroup = vim.api.nvim_create_augroup
  local view_group = augroup("auto_view", { clear = true })

    autocmd("BufWinEnter", {
    desc = "unfold all folds when a buffer is opened",
    group = view_group,
    callback = function(args)
      local buf = args.buf  -- Get the buffer from args
      if not vim.b[buf].view_activated then
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
        local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit", "on" }
        if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) and already_loaded_buffers[buf] == nil then
          already_loaded_buffers[buf] = true
          vim.cmd("normal! zR")
        end
      end
    end,
  })
end

return M
