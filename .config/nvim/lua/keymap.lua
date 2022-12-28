vim.g.mapleader = " "

local wk = require('which-key')
wk.setup()

wk.register({
  e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
}, { prefix = "<leader>" })
