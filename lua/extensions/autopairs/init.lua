local M = {}

function M.setup()
  require 'nvim-autopairs'.setup {
    disable_filetype = { "TelescopePrompt" },
    disable_in_macro = true,
    disable_in_visualblock = false,
    enable_moveright = true,
    enable_afterquite = true,
    enable_check_brakcet_line = true,
    enable_bracket_in_quote = true,
    break_undo = true
  }
end

return M
