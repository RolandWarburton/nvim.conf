require'neoclip'.setup {
  histour = 1000,
  enable_persistent_history = false, -- causes a startup error
  length_limit = 1048576,
  db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3", -- usually in $HOME/.local/share/nvim
  filter = nil,
  preview = true,
  default_register = {'"', '+', '*'},
  default_register_macros = 'a',
  enable_macro_history = true,
  content_spec_column = false,
  on_paste = {
    set_reg = false
  },
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-p>',
        paste_behind = '<c-k>',
        replay = '<c-q>',  -- replay a macro
        delete = '<c-d>',  -- delete an entry
        custom = {},
      },
      n = {
        select = '<cr>',
        paste = 'p',
        paste_behind = 'P',
        replay = 'q',
        delete = 'd',
        custom = {},
      },
      fzf = {
        select = 'default',
        paste = 'ctrl-p',
        paste_behind = 'ctrl-k',
        custom = {},
      },
    }
  }
}

-- load neoclip as an extension for telescope
require'telescope'.load_extension'neoclip'
