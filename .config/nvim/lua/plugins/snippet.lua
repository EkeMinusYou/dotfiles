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

    vim.api.nvim_set_keymap(
      'i',
      '<Tab>',
      "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
      { expr = true, noremap = false }
    )
    vim.api.nvim_set_keymap(
      's',
      '<Tab>',
      "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
      { expr = true, noremap = false }
    )
    vim.api.nvim_set_keymap(
      'i',
      '<S-Tab>',
      "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
      { expr = true, noremap = false }
    )
    vim.api.nvim_set_keymap(
      's',
      '<S-Tab>',
      "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
      { expr = true, noremap = false }
    )
  end,
  lazy = true,
}
