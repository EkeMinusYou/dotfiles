local helper = require('utils.helper')

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
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
vim.keymap.set('n', 'gf', function()
  helper.lsp_formatting({ async = true, timeout_ms = 5000 })
end)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<cr>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
-- define by lspsaga
-- vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
-- vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')

-- kensaku
vim.keymap.set('c', '<CR>', '<Plug>(kensaku-search-replace)<CR>')

-- terminal
vim.keymap.set('n', '<leader>g', '<cmd>terminal lazygit<cr>')
