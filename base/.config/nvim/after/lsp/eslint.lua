---@type vim.lsp.Config
return {
  root_markers = {
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.json',
    'eslint.config.mjs',
  },
  workspace_required = true,
}
