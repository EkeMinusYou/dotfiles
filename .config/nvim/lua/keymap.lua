local helper = require('utils.helper')

-- global
vim.g.mapleader = ' '
vim.g.termwinkey = '<C-g>'

-- emacs keybinding in insert-mode
vim.keymap.set('i', '<c-b>', '<left>')
vim.keymap.set('i', '<c-f>', '<right>')
vim.keymap.set('i', '<c-p>', '<up>')
vim.keymap.set('i', '<c-n>', '<down>')
vim.keymap.set('i', '<c-a>', '<c-o>0')
vim.keymap.set('i', '<c-e>', '<c-o>$')
vim.keymap.set('i', '<c-s>', '<cmd>update<cr>')
vim.keymap.set('i', '<m-b>', '<c-o>b')
vim.keymap.set('i', '<m-f>', '<c-o>w')

-- lsp
vim.keymap.set('n', 'gf', function()
  helper.lsp_formatting({ async = true, timeout_ms = 5000 })
end)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
vim.keymap.set('n', 'gi', function()
  require('telescope.builtin').lsp_implementations()
end)
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references()
end)
vim.keymap.set('n', '<leader>ld', function()
  require('telescope.builtin').diagnostics()
end)
vim.keymap.set('i', '<c-k>', function()
  helper.lsp_formatting({ async = true, timeout_ms = 5000 })
end)
-- define by lspsaga
-- vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')
-- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
-- vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
-- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

-- kensaku
vim.keymap.set('c', '<CR>', '<Plug>(kensaku-search-replace)<CR>')

-- terminal
-- vim.keymap.set('n', '<leader>g', '<cmd>terminal lazygit<cr>')

-- See: https://zenn.dev/vim_jp/articles/2024-06-05-vim-middle-class-features#%E5%BC%95%E7%94%A8%E7%AC%A6%E3%81%A7%E5%9B%B2%E3%81%BE%E3%82%8C%E3%81%9F%E7%AE%87%E6%89%80%E5%85%A8%E4%BD%93%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%99%E3%82%8B
for _, quote in ipairs({ '"', "'", '`' }) do
  vim.keymap.set({ 'x', 'o' }, 'a' .. quote, '2i' .. quote)
end
