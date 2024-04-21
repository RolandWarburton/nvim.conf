local M = {}

local treesitter = require('nvim-treesitter.configs')

function M.setup()
  treesitter.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
      'bash',
      'c',
      'c_sharp',
      'cmake',
      'comment',
      'cpp',
      'css',
      'dart',
      'diff',
      'dockerfile',
      'embedded_template',
      'fish',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'gomod',
      'gosum',
      'gowork',
      'graphql',
      'hcl',
      'hjson',
      'html',
      'http',
      'ini',
      'javascript',
      'jq',
      'jsdoc',
      'json5',
      'jsonc',
      'jsonnet',
      'latex',
      'lua',
      'luadoc',
      'luap',
      'make',
      'markdown',
      'mermaid',
      'meson',
      'ninja',
      'nix',
      'perl',
      'php',
      'phpdoc',
      'pug',
      'ql',
      'regex',
      'rst',
      'ruby',
      'rust',
      'scss',
      'sql',
      'toml',
      'tsx',
      'typescript',
      'yaml'
    },
    ignore_install = {},
    modules = {},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
      enable = true,
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = 50 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    -- https://github.com/p00f/nvim-ts-rainbow
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 9999,
      colors = {
        -- vsc brackets colorizer 2 theme
        "#EAC502",
        "#DA70D6",
        "#179CFB",
      },
    }
  }
end

return M
