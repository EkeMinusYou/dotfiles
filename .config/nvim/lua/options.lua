vim.opt.clipboard:append('unnamedplus')
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.list = false
vim.opt.number = true
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.showcmd = false
vim.opt.signcolumn = 'yes'
vim.opt.fixendofline = false
vim.opt.shortmess:append('I')
vim.opt.ignorecase = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- disable newline auto comment
vim.opt.fo = vim.opt.fo - 'c'
vim.opt.fo = vim.opt.fo - 'r'
vim.opt.fo = vim.opt.fo - 'o'

-- set 3 when lualine setup
vim.opt.laststatus = 0

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- theme
vim.opt.termguicolors = true
vim.cmd.colorscheme('kanagawa-dragon')
