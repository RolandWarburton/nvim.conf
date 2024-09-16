local M = {}

function M.setup()
  local gitsigns = require('gitsigns')

  gitsigns.setup(
    {
      signs                        = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged                 = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged_enable          = true,
      signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir                 = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked          = true,
      current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority                = 6,
      update_debounce              = 100,
      status_formatter             = nil, -- Use default
      max_file_length              = 40000,
      preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    }
  )
end

function M.keybindings()
  -- jump navigation
  Map('n', ']c', ':Gitsigns next_hunk<cr>')
  Map('n', '[c', ':Gitsigns prev_hunk<cr>')
  Map('v', ']c', ':Gitsigns select_hunk<cr>')
  Map('v', '[c', ':Gitsigns select_hunk<cr>')

  -- staging hunks
  Map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<cr>')
  Map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<cr>')
  Map('n', '<leader>hu', ':Gitsigns undo_stage_hunk<cr>')

  -- git diffs
  Map('n', '<leader>hd', ':Gitsigns diffthis<cr>')
  Map('n', '<leader>td', ':Gitsigns toggle_deleted<cr>')

  -- git blame via gitsigns.nvim plugin
  Map('n', '<leader>gb', ':Gitsigns blame_line<cr>')

  -- git preview hunk
  Map('n', '<leader>gp', ':Gitsigns preview_hunk<cr>')

  -- git toggle to show deleted lines
  vim.api.nvim_create_user_command('GitToggleShowDeletedLines', ':Gitsigns toggle_deleted<cr>', {})

  -- git open diff for the current file
  vim.api.nvim_create_user_command('GitOpenDiff', ':Gitsigns diffthis<cr>', {})
end

return M
