-- allow for the use of :PackerRocks commands

local fn = vim.fn

-- typically this is in ~/.local/share/nvim
-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
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
  use{
    'nvim-lua/plenary.nvim',
    -- tag='9ac3e9541bbabd9d73663d757e4fe48a675bb054',
    branch='master'
  } -- Useful lua functions used in lots of plugins
  use {
    'wbthomason/packer.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    -- tag='1d0cf98a561f7fd654c970c49f917d74fafe1530',
    branch='master'
  } -- Have packer manage itself
  use {
    'neovim/nvim-lspconfig',
    -- tag='710c45bd13928c1f37ef0a714fd49b75f00d7d5e',
    branch='master'
  } -- enable LSP
  use {
    'Mofiqul/vscode.nvim',
    -- tag='dc5f37603ada51db13bc4009cbee628c5857a274',
    branch='main'
  }-- color scheme
  use {
    'nvim-tree/nvim-web-devicons',
    -- tag='4ec26d67d419c12a4abaea02f1b6c57b40c08d7e',
    branch='master'
  }-- for file icons
  use {
    'kyazdani42/nvim-tree.lua',
    -- tag='bb375fb20327c49920c41d2b51c1ce2f4fe7deb3',
    branch='master'
  }-- file tree
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    -- tag='f2645c13205abb9ee3dbcee68416645c69b863c8',
    branch='master'
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build --config Release && \
    cmake --install build --prefix build',
    requires = { { 'nvim-lua/plenary.nvim' } },
    -- tag='580b6c48651cabb63455e97d7e131ed557b8c7e2',
    branch='main'
  }
  use {
    'hrsh7th/nvim-cmp',
    -- tag='e28fb7a730b1bd425fdddfdbd3d36bb84bd77611',
    branch='main'
  }
  use {
    'hrsh7th/cmp-buffer',
    -- tag='3022dbc9166796b644a841a02de8dd1cc1d311fa',
    branch='main'
  } -- completions from buffers
  use {
    'hrsh7th/cmp-path',
    -- tag='91ff86cd9c29299a64f968ebb45846c485725f23',
    branch='main'
  } -- completions for files
  use {
    'hrsh7th/cmp-nvim-lua',
    -- tag='f12408bdb54c39c23e67cab726264c10db33ada8',
    branch='main'
  } -- neovim lua completions
  use {
    'hrsh7th/cmp-nvim-lsp',
    -- tag='0e6b2ed705ddcff9738ec4ea838141654f12eeef',
    branch='main'
  } -- completions from lsp server
  use {
    'ray-x/lsp_signature.nvim',
    -- tag='1fdc742af68f4725a22c05c132f971143be447fc',
    branch='master'
  }
  use {
    'L3MON4D3/LuaSnip',
    config = function()
    require('luasnip').config.set_config {
      history = true,
    }
    require('luasnip.loaders.from_vscode').load {}
    end,
    -- tag='e77fa9ad0b1f4fc6cddf54e51047e17e90c7d7ed',
    branch='master'
  } -- snippets engine for nvim-cmp
  use {
    'rafamadriz/friendly-snippets',
    -- tag='9590ff90759488674cf97fe5d5754a0733ab37bb',
    branch='main'
  } -- snippets collection for various languages
  use {
    'windwp/nvim-autopairs',
    -- tag='7566a86f44bb72ba2b1a609f528a27d93241502d',
    branch='master'
  } -- close things like brackets
  use {
    'kylechui/nvim-surround',
    -- tag='e6047128e57c1aff1566fb9f627521d2887fc77a',
    branch='main'
  } -- change quotes cs"'
  use {
    'AckslD/nvim-neoclip.lua',
      requires = {
       { 'tami5/sqlite.lua', module = 'sqlite' },
       { 'nvim-telescope/telescope.nvim' },
    },
    -- tag='591f1b62343efe3e369e4831cd91e1875f3a08f4',
    branch='main'
  }
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    -- tag='69a6ca7c41b023ebf9cad70778e227b3209b40c4',
    branch='master'
  } -- git intergrations
  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    -- tag='f9ddbe798cb92854a383e2377482a49139a52c3d',
    branch='main'
  } -- git diff for neogit
  use {
    'lewis6991/gitsigns.nvim',
    -- tag='7dfe4be94b4f84a9931098f0f0f618d055e50bd5',
    branch='main'
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    -- tag='63e1ab06f362c7fcd8a1b6f95665b55814190986',
    branch='main'
  }
  use {
    'numToStr/Comment.nvim',
    -- tag='a89339ffbee677ab0521a483b6dac7e2e67c907e',
    branch='master'
  }
  use {
    'lewis6991/spellsitter.nvim',
    -- tag='4af8640d9d706447e78c13150ef7475ea2c16b30',
    branch='master'
  }
  use {
    'andweeb/presence.nvim',
    -- tag='87c857a56b7703f976d3a5ef15967d80508df6e6',
    branch='main'
  }
  use {
    'jbyuki/venn.nvim',
    -- tag='c114563960b8fb1197695d42798d1f3e7190b798',
    branch='main'
  }
  use {
    'anuvyklack/hydra.nvim',
    -- tag='3ced42c0b6a6c85583ff0f221635a7f4c1ab0dd0',
    branch='master'
  }
  use {
    'Djancyp/better-comments.nvim',
    -- tag='0630bb0d0c280886edc05a15c24e53a1f5e5197a',
    branch='main'
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    -- tag='82bcd8483e0b802bd5f639046c88aecfddbab508',
    branch='master'
  -- to install new TS language support
  -- :TSUpdateSync
  -- :TSInstall typescript
  }
  use {
    'nvim-treesitter/nvim-treesitter-context',
    -- tag='fb445fa2aee9f0dce7257bb6f628795e6e13d6e6',
    branch='master'
  }
  use {
    'p00f/nvim-ts-rainbow',
    -- tag='ef95c15a935f97c65a80e48e12fe72d49aacf9b9',
    branch='master'
  }
  use {
    'ggandor/leap.nvim',
    -- tag='ef95c15a935f97c65a80e48e12fe72d49aacf9b9',
    branch='main'
  }
  use {
    'mfussenegger/nvim-dap',
    -- tag='6cedcb527e264c8f25e86afa8dae74c6692dee51',
    branch='master'
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    print('syncing')
    require('packer').sync()
    print('synced')
  end
end)

