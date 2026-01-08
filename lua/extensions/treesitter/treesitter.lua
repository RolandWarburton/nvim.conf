local M = {}

local pattern = {
  'c',
  'elixir',
  'heex',
  'html',
  'java',
  'javascript',
  'lua',
  'markdown',
  'query',
  'typescript',
  'typescriptreact',
  'vim',
  'vimdoc',
  'yaml',
  'go'
}

local function ts_start(args)
  local ft = args.match
  local lang = vim.treesitter.language.get_lang(ft)

  -- load treesitter
  local ok, treesitter = pcall(require, 'nvim-treesitter')
  if not ok then
    print("failed to load nvim-treesitter")
    return
  end

  -- start treesitter
  treesitter.install({ lang }):await(function(err)
    if err then
      vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
      return
    end

    pcall(vim.treesitter.start, args.buf)
    -- folding
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- indenting
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end)
end

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = pattern,
    callback = function(args)
      ts_start(args)
    end,
  })
end

return M
