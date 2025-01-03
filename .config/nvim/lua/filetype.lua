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
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '.swift-format',
  group = 'filetype',
  command = 'setlocal filetype=json',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.swiftinterface',
  group = 'filetype',
  command = 'setlocal filetype=swift',
})

-- swift
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'LspAttach' }, {
  pattern = '*.swift',
  group = 'filetype',
  command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2 commentstring=//\\ %s',
})

-- terraform
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'LspAttach' }, {
  pattern = '*.tf',
  group = 'filetype',
  command = 'setlocal shiftwidth=2 tabstop=2 commentstring=//\\ %s',
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

-- Makefile
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    'makefile',
    'Makefile',
  },
  group = 'filetype',
  command = 'setlocal noexpandtab tabstop=4 shiftwidth=4',
})

-- yaml
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'LspAttach' }, {
  pattern = {
    '*.yaml',
    '*.yml',
  },
  group = 'filetype',
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

-- env
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '.env.*',
  group = 'filetype',
  command = 'setlocal filetype=sh',
})

-- sql
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.ddl',
  group = 'filetype',
  command = 'setlocal filetype=sql',
})

-- atlas
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = 'atlas.hcl',
  group = 'filetype',
  command = 'setlocal filetype=atlas-config',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.pg.hcl',
  group = 'filetype',
  command = 'setlocal filetype=atlas-schema-postgresql',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.my.hcl',
  group = 'filetype',
  command = 'setlocal filetype=atlas-schema-mysql',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.lt.hcl',
  group = 'filetype',
  command = 'setlocal filetype=atlas-schema-sqlite',
})
