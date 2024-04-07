require('nvim-tmux-navigation').setup {
  disable_when_zoomed = true, -- defaults to false
}

local nvim_tmux_nav = require('nvim-tmux-navigation')

-- both <C-n> and <C-a>n can be used inside neovim
-- only <C-a>n can be used outside
-- this is become of limitations of keystrokes that tmux can send (as far as i can figure out)
-- further reasoning is below on what can/cannot be done

-- i can only figure out how to send <C-n> keys to neovim instead of <C-a>n
-- these keybinds are here to be intercepted when we are going INTO a neovim pane
vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)

-- these keybinds are here when we are going OUTSIDE of a neovim pane
vim.keymap.set('n', "<C-a>h", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-a>j", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-a>k", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-a>l", nvim_tmux_nav.NvimTmuxNavigateRight)
