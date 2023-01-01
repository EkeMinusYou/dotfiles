vim.g.mapleader = " "

-- disable unused keymap
vim.keymap.set('n', '<ZZ>', '<Nop>')
vim.keymap.set('n', '<ZQ>', '<Nop>')
vim.keymap.set('n', '<Q>', '<Nop>')

local wk = require('which-key')
wk.setup()

wk.register({
  e = { "<CMD>NvimTreeToggle<CR>", "Explorer" },
  g = { "<CMD>lua Toggle_lazygit()<CR>", "Git" },
  k = { "<CMD>lua Toggle_k9s()<CR>", "Git" },
  t = { "<CMD>ToggleTerm direction=vertical<CR>", "Terminal" },
  f = { "<CMD>Telescope find_files<CR>", "Find files"},
  F = { "<CMD>Telescope live_grep<CR>", "Grep"}
}, { prefix = "<leader>", mode = "n" })

-- window movement
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- terminal window navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

-- lsp
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
