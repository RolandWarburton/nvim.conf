local M = {}

function M.setup()
  require 'treesitter-context'.setup {
    max_lines = 0,        -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = {          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        'class',
        'function',
        'method',
        'for',
        'while',
        'if',
        'switch',
        'case',
      },
      -- Patterns for specific filetypes
      -- If a pattern is missing, *open a PR* so everyone can benefit.
      tex = {
        'chapter',
        'section',
        'subsection',
        'subsubsection',
      },
      rust = {
        'impl_item',
        'struct',
        'enum',
      },
      markdown = {
        'section',
      },
    },
  }
end

return M
