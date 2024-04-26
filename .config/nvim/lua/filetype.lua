vim.api.nvim_create_augroup('filetype', {})

-- Git
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '.gitconfig-*',
  group = 'filetype',
  command = 'setlocal filetype=gitconfig',
})

-- Swift
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'filetype',
  pattern = '*.swift',
  callback = function()
    if vim.fn.executable('sourcekit-lsp') == 1 then
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local root_dir = vim.fs.dirname(vim.fs.find({
        'Package.swift',
        '.git',
      }, { upward = true })[1])
      vim.lsp.start({
        name = 'sourcekit-lsp',
        capabilities = capabilities,
        cmd = { 'sourcekit-lsp' },
        root_dir = root_dir,
      })
    end
  end,
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
