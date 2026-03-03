---@type vim.lsp.Config
return {
  cmd = { 'stylelint-lsp', '--stdio', '**/{*.css,*vue,*js,*.jsx,*ts,*.tsx,*.html}' },
  filetypes = {
    'css',
    'scss',
    'less',
    'sass',
    'html',
    'vue',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
}