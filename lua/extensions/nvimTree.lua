require 'nvim-tree'.setup {
  update_cwd = true,
  view = {
    mappings = {
      custom_only = false,
      list = {
        -- custom mappings go here :help nvim-tree-mappings
        -- https://github.com/kyazdani42/nvim-tree.lua#mappings

        -- ctrl + n create file (add trailing / to create directory)
        { key = {"<C-n>" }, action = "create", mode = "n"},

        -- move the root directory to the currently selected one
        { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" }
      }
    }
  }
}

-- automatically close nvim tree if its the last window open
-- https://github.com/kyazdani42/nvim-tree.lua/discussions/1115
-- vim.api.nvim_create_autocmd("BufEnter", {
--   nested = true,
--   callback = function()
--     if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
--       vim.cmd "quit"
--     end
--   end
-- })
