return {
  'hrsh7th/vim-vsnip',
  dependencies = {
    { 'golang/vscode-go' },
    { 'rafamadriz/friendly-snippets' },
  },
  config = function()
    local dirs = { '~/.vsnip' }
    local snippetsDir = vim.fn.stdpath('data') .. '/lazy/friendly-snippets/snippets'
    table.insert(dirs, snippetsDir)
    vim.g.vsnip_snippet_dirs = dirs
  end,
  lazy = true,
}
