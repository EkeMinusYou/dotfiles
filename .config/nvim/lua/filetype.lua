vim.api.nvim_create_augroup('filetype', {})

-- Git
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '.gitconfig-*',
  group = 'filetype',
  command = 'setlocal filetype=gitconfig',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = 'Package.resolved',
  group = 'filetype',
  command = 'setlocal filetype=json',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.xcstrings',
  group = 'filetype',
  command = 'setlocal filetype=json',
})

-- CocoaPods
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.podspec',
  group = 'filetype',
  command = 'setlocal filetype=ruby',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = 'Podfile',
  group = 'filetype',
  command = 'setlocal filetype=ruby',
})

-- brewfile
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = 'Brewfile',
  group = 'filetype',
  command = 'setlocal filetype=ruby',
})
