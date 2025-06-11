local M = {}

function M.setup()
  -- null-ls configuration

  local home = os.getenv("HOME")
  home = home == nil and "/home/roland" or home

  -- you can check if you have a linter installed for a language by running
  -- (for example to check eslint) :echo executable('eslint')
  -- 1 indicates it is present
  local null_ls = require 'null-ls'

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions

  -- returns boolean if this looks like a node environment
  local is_node_root = function(utils)
    return utils.root_has_file({ "package.json" })
  end

  local sources = {
    -------------------------------------------------------------------------------------------------
    -- JAVASCRIPT/TYPESCRIPT ------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------
    diagnostics.eslint.with({
      condition = is_node_root,
    }),
    code_actions.eslint.with({
      condition = is_node_root
    }),
    -- formatting.prettier.with({
    --   condition = is_node_root
    -- }),
    formatting.deno_fmt,
    -------------------------------------------------------------------------------------------------
    -- MARKDOWN -------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#markdownlint=
    diagnostics.markdownlint.with({
      args = function(params)
        return {
          "--stdin",
          "--config",
          home .. "/.config/nvim/conf/markdownlint.json"
        }
      end
    }),
    -- format markdown with prettier
    formatting.prettierd.with({
      filetypes = {
        "markdown"
      }
    }),
    -------------------------------------------------------------------------------------------------
    -- VALE -----------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#vale
    diagnostics.vale.with({
      args = function(params)
        return {
          "--no-exit",
          "--output",
          "JSON",
          "--ext",
          ".",
          "--config",
          home .. "/.config/vale/vale.ini",
          vim.fn.expand('%:p') -- prints the absolute file path
        }
      end
    }),
    -------------------------------------------------------------------------------------------------
    -- GOLANG ---------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#gofmt=
    formatting.gofmt.with({
      command = "gofmt",
      args = function(params)
        return {
          vim.fn.expand('%:p')
        }
      end
    }),

    -------------------------------------------------------------------------------------------------
    -- GOLANG ---------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------
    -- https://github.com/JohnnyMorganz/StyLua
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--config-path", vim.fn.expand("~/.config/stylua.toml") },
    }),
    -------------------------------------------------------------------------------------------------
    -- GITSIGNS -------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------
    code_actions.gitsigns,
  }

  null_ls.setup({
    debug = true,
    sources = sources,
    on_attach = function(client, bufnr)
      -- C and C++ seems to cause issues with null-ls
      -- so i just disabled it
      local ft = vim.bo[bufnr].filetype
      if ft == "c" or ft == "cpp" then
        client.stop()
        return
      end

      -- Add other on_attach logic here if needed
    end,
  })
end

return M
