local function ensure_yaml_ls_installed()
  if vim.fn.executable('yaml-language-server') == 1 then return end
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then
    vim.notify("yaml-language-server not in PATH and Mason not available", vim.log.levels.WARN)
    return
  end
  local pkg = registry.get_package('yaml-language-server')
  if not pkg:is_installed() then
    vim.notify("Installing yaml-language-server via Mason...", vim.log.levels.INFO)
    pkg:install()
  end
end

ensure_yaml_ls_installed()
if vim.fn.executable('yaml-language-server') == 1 then
  vim.lsp.config('yamlls', {
    settings = {
      yaml = {
        schemas = {
          ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = {
            'docker-compose*.yml',
            'docker-compose*.yaml',
            'compose*.yml',
            'compose*.yaml',
          },
          ['https://json.schemastore.org/ansible-playbook.json'] = {
            '**/ansible-configs/playbooks/*.yml',
            '**/ansible-configs/playbooks/*.yaml',
          },
          ['https://json.schemastore.org/ansible-tasks.json'] = {
            '**/ansible-configs/tasks/*.yml',
            '**/ansible-configs/tasks/*.yaml',
            '**/ansible-configs/handlers/*.yml',
            '**/ansible-configs/handlers/*.yaml',
          },
        },
      },
    },
  })
  vim.lsp.enable('yamlls')
else
  vim.notify("yaml-language-server is missing from PATH", vim.log.levels.WARN)
end
