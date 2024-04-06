-- allow for the use of :PackerRocks commands

local fn = vim.fn

-- typically this is in ~/.local/share/nvim
-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install your plugins here
return packer.startup(function(use)
  use {
    'nvim-lua/plenary.nvim',
    branch = 'master'
  } -- Useful lua functions used in lots of plugins
  use {
    "folke/twilight.nvim",
    opts = {
      treesitter = true,
      exclude = { 'md' }
    }
  }
  use {
    'wbthomason/packer.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    branch = 'master'
  } -- Have packer manage itself
  use {
    'neovim/nvim-lspconfig',
    branch = 'master'
  } -- enable LSP
  use {
    'Mofiqul/vscode.nvim',
    branch = 'main'
  } -- color scheme
  use {
    'nvim-tree/nvim-web-devicons',
    branch = 'master'
  } -- for file icons
  use {
    'kyazdani42/nvim-tree.lua',
    branch = 'master'
  } -- file tree
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    branch = 'master'
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build --config Release && \
    cmake --install build --prefix build',
    requires = { { 'nvim-lua/plenary.nvim' } },
    branch = 'main'
  }
  use {
    'hrsh7th/nvim-cmp',
    branch = 'main'
  }
  use {
    'hrsh7th/cmp-buffer',
    branch = 'main'
  } -- completions from buffers
  use {
    'hrsh7th/cmp-path',
    branch = 'main'
  } -- completions for files
  use {
    'hrsh7th/cmp-nvim-lua',
    branch = 'main'
  } -- neovim lua completions
  use {
    'hrsh7th/cmp-nvim-lsp',
    branch = 'main'
  } -- completions from lsp server
  use {
    'ray-x/lsp_signature.nvim',
    branch = 'master'
  }
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip').config.set_config {
        history = true,
      }
      require('luasnip.loaders.from_vscode').load {}
    end,
    branch = 'master'
  } -- snippets engine for nvim-cmp
  use {
    'rafamadriz/friendly-snippets',
    branch = 'main'
  } -- snippets collection for various languages
  use {
    'windwp/nvim-autopairs',
    branch = 'master'
  } -- close things like brackets
  use {
    'kylechui/nvim-surround',
    branch = 'main'
  } -- change quotes cs"'
  use {
    'AckslD/nvim-neoclip.lua',
    requires = {
      { 'tami5/sqlite.lua',             module = 'sqlite' },
      { 'nvim-telescope/telescope.nvim' },
    },
    branch = 'main'
  }
  use {
    'NeogitOrg/neogit',
    requires = 'nvim-lua/plenary.nvim',
    branch = 'master'
  } -- git intergrations
  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    branch = 'main'
  } -- git diff for neogit
  use {
    'lewis6991/gitsigns.nvim',
    branch = 'main'
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    branch = 'main'
  }
  use {
    'numToStr/Comment.nvim',
    branch = 'master'
  }
  use {
    'andweeb/presence.nvim',
    branch = 'main'
  }
  use {
    'jbyuki/venn.nvim',
    branch = 'main'
  }
  use {
    'anuvyklack/hydra.nvim',
    branch = 'master'
  }
  use {
    'Djancyp/better-comments.nvim',
    branch = 'main'
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master'
    -- to install new TS language support
    -- :TSUpdateSync
    -- :TSInstall typescript
  }
  use {
    'nvim-treesitter/nvim-treesitter-context',
    branch = 'master'
  }
  use {
    'p00f/nvim-ts-rainbow',
    branch = 'master'
  }
  use {
    'ggandor/leap.nvim',
    branch = 'main'
  }
  use {
    'mfussenegger/nvim-dap',
    branch = 'master'
  }
  use { 'RRethy/vim-illuminate', branch = 'master' }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    print('syncing')
    require('packer').sync()
    print('synced')
  end
end)
