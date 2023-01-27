-- workaround https://github.com/equalsraf/neovim-qt/issues/259
vim.keymap.set('t', '<s-space>', '<space>')
vim.keymap.set('t', '<s-backspace>', '<backspace>')
vim.keymap.set('t', '<s-enter>', '<enter>')
vim.keymap.set('t', '<c-space>', '<space>')
vim.keymap.set('t', '<c-backspace>', '<backspace>')
vim.keymap.set('t', '<c-enter>', '<enter>')

-- window movement
vim.keymap.set('n', '<C-S-h>', '<C-w>h')
vim.keymap.set('n', '<C-S-j>', '<C-w>j')
vim.keymap.set('n', '<C-S-k>', '<C-w>k')
vim.keymap.set('n', '<C-S-l>', '<C-w>l')
vim.keymap.set('t', '<C-S-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-S-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-S-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-S-l>', '<C-\\><C-N><C-w>l')

-- emacs keybinding in insert-mode
vim.keymap.set('i', '<c-b>', '<Left>')
vim.keymap.set('i', '<c-f>', '<Right>')
vim.keymap.set('i', '<c-p>', '<Up>')
vim.keymap.set('i', '<c-n>', '<Down>')

-- lsp
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format({async = true, timeout_ms=2000})<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- define by lspsaga
-- vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
-- vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
