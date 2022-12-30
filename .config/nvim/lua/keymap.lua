vim.g.mapleader = " "

local wk = require('which-key')
wk.setup()

wk.register({
  e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
}, { prefix = "<leader>" })

-- window movement
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')