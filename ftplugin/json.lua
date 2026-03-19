local function ensure_jsonls_installed()
  if vim.fn.executable('vscode-json-language-server') == 1 then return end
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    vim.notify("vscode-json-language-server not in PATH and Mason not available", vim.log.levels.WARN)
    return
  end
  local pkg = registry.get_package('json-lsp')
  if not pkg:is_installed() then
    vim.notify("Installing json-lsp via Mason...", vim.log.levels.INFO)
    pkg:install()
  end
end

ensure_jsonls_installed()
if vim.fn.executable('vscode-json-language-server') == 1 then
  vim.lsp.config('jsonls', {
    settings = {
      json = {
        schemas = {
          {
            fileMatch = { 'deno.json', 'deno.jsonc' },
            url = 'https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json',
          },
        },
      },
    },
  })
  vim.lsp.enable('jsonls')
else
  vim.notify("vscode-json-language-server is missing from PATH", vim.log.levels.WARN)
end
