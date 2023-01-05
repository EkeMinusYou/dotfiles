vim.opt.clipboard:append 'unnamedplus'
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.number = true
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.showcmd = false
vim.opt.signcolumn = 'yes'
vim.opt.fixendofline = false
vim.opt.shortmess:append 'I'

-- lualine
vim.opt.laststatus = 3

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- theme
vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight-moon')
