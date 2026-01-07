require('extensions.nvimTree').setup()
require('extensions.treesitter').setup()
require('extensions.telescope').setup()
require('extensions.surround').setup()
require('extensions.mason').setup()
require('extensions.nvimTmuxNavigation').setup()
require('extensions.neogit').setup()
require('extensions.neoclip').setup()
require('extensions.illuminate').setup()
require('extensions.gitsigns').setup()
require('extensions.comment-highlight').setup()
require('extensions.completion').setup()
require('extensions.comment').setup()
require('extensions.autopairs').setup()
require('extensions.venn').setup()
require('extensions.twilight').setup()
require('extensions.colorizer').setup()
if _G.neovim_config.extensions.enable_tiny_go then
  require('extensions.tinygo').setup()
end
--require('extensions.null-ls').setup() -- depricated
-- require('extensions.hydra').setup() -- disabled due to bug see issue 60
-- require('extensions.maximize').setup()
