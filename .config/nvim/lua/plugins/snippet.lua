return {
  'EkeMinusYou/vim-vsnip',
  dependencies = {
    { 'golang/vscode-go' },
    { 'microsoft/vscode' },
  },
  config = function()
    local vscodeDir = vim.fn.stdpath('data') .. '/lazy/vscode'
    vim.g.vsnip_snippet_dirs = {
      vscodeDir .. '/extensions/typescript-basics/snippets',
    }
  end,
}
