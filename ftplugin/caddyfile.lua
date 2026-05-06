local ok, treesitter = pcall(require, 'nvim-treesitter')
if not ok then return end

treesitter.install({ 'caddy' }):await(
  function(err)
    if err then
      vim.notify('Treesitter install error for caddy: ' .. err)
      return
    end
    pcall(vim.treesitter.start, 0, 'caddy')
  end
)
