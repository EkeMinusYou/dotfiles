-- workaround https://github.com/equalsraf/neovim-qt/issues/259
vim.keymap.set('t', '<s-space>', '<space>')
vim.keymap.set('t', '<s-backspace>', '<backspace>')
vim.keymap.set('t', '<s-enter>', '<enter>')
vim.keymap.set('t', '<c-space>', '<space>')
vim.keymap.set('t', '<c-backspace>', '<backspace>')
vim.keymap.set('t', '<c-enter>', '<enter>')

-- window movement
vim.keymap.set('n', '<c-s-h>', '<c-w>h')
vim.keymap.set('n', '<c-s-j>', '<c-w>j')
vim.keymap.set('n', '<c-s-k>', '<c-w>k')
vim.keymap.set('n', '<c-s-l>', '<c-w>l')
vim.keymap.set('t', '<c-s-h>', '<c-\\><c-n><c-w>h')
vim.keymap.set('t', '<c-s-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<c-s-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<c-s-l>', '<c-\\><c-n><c-w>l')

-- emacs keybinding in insert-mode
vim.keymap.set('i', '<c-b>', '<left>')
vim.keymap.set('i', '<c-f>', '<right>')
vim.keymap.set('i', '<c-p>', '<up>')
vim.keymap.set('i', '<c-n>', '<down>')
vim.keymap.set('i', '<m-b>', '<c-o>b')
vim.keymap.set('i', '<m-f>', '<c-o>w')

-- lsp
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format({async = true, timeout_ms=5000})<cr>')
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
