vim.g.mapleader = " "

require('which-key').register({
  ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
}, { prefix = "<leader>" })
