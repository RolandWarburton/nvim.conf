local M = {}

function M.setup()
  -- GENERAL SETTINGS
  local home = require 'os'.getenv('HOME')

  -- ensure filetype detection is turned on
  vim.opt.filetype = "on"

  -- show a column bar to suggest the line length
  vim.opt.colorcolumn = "100"

  -- show the absolute line number for the current line
  vim.opt.number = true

  -- soft tab 2 spaces
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.expandtab = true

  -- make tabs 2 spaces long
  vim.opt.tabstop = 2

  -- relative number lines
  vim.opt.relativenumber = true

  -- ignore case for grep
  vim.opt.ignorecase = true

  -- shows better messages
  vim.opt.cmdheight = 1

  -- allow terminal colors
  vim.opt.termguicolors = true

  -- enable native spell checking
  vim.cmd('set spell spelllang=en_us')
  vim.cmd('set spellfile=' .. home .. '/.config/nvim/spell/en.utf-8.add')

  -- Fix comments (see :h fo-table and :h formatoptions)
  -- -= is subtracting the following values
  -- c -> auto-wrap comments using textwidth
  -- r -> auto insert comment after pressing <Enter> in insert mode
  -- o -> auto insert comment after pressing "o" or "O" in normal mode
  vim.cmd('autocmd BufEnter * set formatoptions-=cro')

  -- create splits in these directions
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  -- use the clipboard for ALL operations (instead of having to use + register)
  vim.opt.clipboard = 'unnamedplus'

  -- disable word wrap
  vim.opt.wrap = false

  -- when scrolling, do it 8 chars at a time (default is 1)
  vim.opt.sidescroll = 8

  -- offset the side scrolling to start scrolling at an effective 8+8 chars
  vim.opt.sidescrolloff = 8

  -- keep N lines above and below cursor
  vim.opt.scrolloff = 10

  -- set the font for gui
  vim.opt.guifont = "Hack:h10"

  -- wait this long for a command to finish
  vim.opt.timeoutlen = 1000

  -- the width of the gutter numbers
  vim.opt.numberwidth = 1

  -- allow use of mouse
  vim.opt.mouse = 'a'

  -- use tree-sitter for folding
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

  -- highlight the current line
  vim.opt.cursorline = true

  -- highlight the cursors column
  vim.opt.cursorcolumn = true

  -- disable the close (X) button on vim tab line
  vim.cmd('set guioptions-=e')

  -- disable provider.perl
  vim.api.nvim_set_var("loaded_perl_provider", 0)

  -- disable provider.python3
  vim.api.nvim_set_var("loaded_python3_provider", 0)

  -- copy as root
  local function copy_as_root()
    local user = os.getenv("USER")
    if user == "root" then
      -- make some assumptions about what the users wayland session might be
      vim.fn.setenv("WAYLAND_DISPLAY", "wayland-1")
      vim.fn.setenv("XDG_RUNTIME_DIR", "/run/user/1000")
    end
  end
  copy_as_root()
end

return M
