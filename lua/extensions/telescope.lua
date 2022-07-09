require('telescope').setup {
  defaults ={
    file_ignore_patterns = {"node_modules", ".git/"},
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call load_extension('fzf')
require('telescope').load_extension('fzf')
