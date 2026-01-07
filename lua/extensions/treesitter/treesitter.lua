local M = {}

---@diagnostic disable-next-line: deprecated
local unpack = unpack or table.unpack

local treesitter = require('nvim-treesitter')
local pattern = {
  'java',
  'c',
  'lua',
  'vim',
  'vimdoc',
  'query',
  'elixir',
  'heex',
  'javascript',
  'typescript',
  'html',
  'yaml'
}

function M.setup()
  treesitter.setup({
    install_dir = vim.fn.stdpath('data') .. '/site'
  })
  treesitter.install(pattern)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { "typescriptreact" },
    callback = function(args)
      -- do not run treesitter on large buffers
      local max_filesize = 25 * 1024 -- 25kb
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
      if ok and stats and stats.size > max_filesize then
        print("skipping large file")
        return
      end
      -- syntax highlighting, provided by Neovim
      vim.treesitter.start()
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      vim.opt.foldlevel = 99
      -- indentation, provided by nvim-treesitter
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      -- rainbow delimiters
    end,
  })
  -- treesitter.setup {
  --   -- A list of parser names, or "all" (the five listed parsers should always be installed)
  --   ensure_installed = {
  --     'bash',
  --     'diff',
  --     'git_config',
  --     'git_rebase',
  --     'gitattributes',
  --     'gitcommit',
  --     'gitignore',
  --     'html',
  --     'ini',
  --     'markdown',
  --     'regex',
  --     'yaml',
  --     'json'
  --   },
  --   ignore_install = {},
  --   modules = {},
  --
  --   -- Install parsers synchronously (only applied to `ensure_installed`)
  --   sync_install = false,
  --
  --   -- Automatically install missing parsers when entering buffer
  --   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  --   auto_install = true,
  --
  --   highlight = {
  --     enable = true,
  --     -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
  --     disable = function(lang, buf)
  --       local max_filesize = 50 * 1024 -- 100 KB
  --       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  --       if ok and stats and stats.size > max_filesize then
  --         return true
  --       end
  --     end,
  --
  --     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  --     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  --     -- Using this option may slow down your editor, and you may see some duplicate highlights.
  --     -- Instead of true it can also be a list of languages
  --     additional_vim_regex_highlighting = false,
  --   },
  -- }
  -- local rainbow = require('extensions.treesitter.rainbow')
  -- rainbow.setup()
end

return M
