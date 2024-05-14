local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'nvim-lua/plenary.nvim',
  },
  {
    "folke/twilight.nvim",
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    'Mofiqul/vscode.nvim',
  },
  {
    'nvim-tree/nvim-web-devicons',
  },
  {
    'kyazdani42/nvim-tree.lua',
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build --config Release && \
    cmake --install build --prefix build',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
  },
  {
    'hrsh7th/nvim-cmp',
  },
  {
    'hrsh7th/cmp-buffer',
  },
  {
    'hrsh7th/cmp-path',
  },
  {
    'hrsh7th/cmp-nvim-lua',
  },
  {
    'hrsh7th/cmp-nvim-lsp',
  },
  {
    'ray-x/lsp_signature.nvim',
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip"
    },
  },
  {
    'rafamadriz/friendly-snippets',
  },
  {
    'windwp/nvim-autopairs',
  },
  {
    'kylechui/nvim-surround',
  },
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      'nvim-telescope/telescope.nvim'
    }
  },
  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  {
    'lewis6991/gitsigns.nvim',
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
  },
  {
    'numToStr/Comment.nvim',
  },
  {
    'jbyuki/venn.nvim',
  },
  {
    'anuvyklack/hydra.nvim',
  },
  {
    'Djancyp/better-comments.nvim',
  },
  {
    'nvim-treesitter/nvim-treesitter',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
  {
    'p00f/nvim-ts-rainbow',
  },
  {
    'ggandor/leap.nvim',
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = 'anuvyklack/hydra.nvim',
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    }
  },
  {
    'leoluz/nvim-dap-go'
  },
  { 'RRethy/vim-illuminate' },
  { 'alexghergh/nvim-tmux-navigation' },
  { "onsails/lspkind.nvim" }
})
