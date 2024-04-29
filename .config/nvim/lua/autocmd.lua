local helper = require('utils.helper')

vim.api.nvim_create_augroup('format', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'format',
  pattern = {
    '*.lua',
    '*.js',
    '*.jsx',
    '*.ts',
    '*.tsx',
    '*.go',
  },
  callback = function()
    helper.lsp_formatting({ async = false, timeout_ms = 5000 })
  end,
})

-- denolscache
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'format',
  pattern = {
    '*.js',
    '*.jsx',
    '*.ts',
    '*.tsx',
  },
  callback = function()
    if helper.is_lsp_active('denols') then
      vim.api.nvim_command('DenolsCache')
    end
  end,
})

vim.api.nvim_create_augroup('indent', {})
-- swift rewrite indent
vim.api.nvim_create_autocmd('FileType', {
  group = 'indent',
  pattern = {
    'swift',
  },
  callback = function()
    vim.api.nvim_command('setlocal shiftwidth=2 tabstop=2 softtabstop=2')
  end,
})

vim.api.nvim_create_augroup('wincmdl', {})
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'trouble',
  },
  callback = function()
    vim.api.nvim_command('wincmd L')
  end,
})

-- Highlight on yank
-- See https://github.com/LazyVim/LazyVim/blob/53e1637a864cb7e8f21af107b8073bc8b24acd11/lua/lazyvim/config/autocmds.lua#L7
-- this is enalbed by yanky.nvim
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })

-- See https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
local root_names = { '.git' }
local root_cache = {}
local set_root = function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then
    return
  end
  path = vim.fs.dirname(path)

  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then
      return
    end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  vim.fn.chdir(root)
end

vim.api.nvim_create_augroup('setroot', {})
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'setroot',
  callback = set_root,
})

-- IME Auto Switch
local disable_ime = function()
  if vim.fn.has('mac') == 1 then
    vim.fn.system('im-select com.apple.keylayout.ABC')
  end
end

vim.api.nvim_create_augroup('ime', {})
vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'ime',
  callback = disable_ime,
})

-- terminal
vim.api.nvim_create_augroup('terminal', {})
vim.api.nvim_create_autocmd('TermOpen', {
  group = 'terminal',
  callback = function()
    vim.api.nvim_command('startinsert')
    vim.api.nvim_command('setlocal nonumber norelativenumber')
  end,
})
-- See: https://github.com/neovim/neovim/issues/14986#issuecomment-902705190
vim.api.nvim_create_autocmd('TermClose', {
  group = 'terminal',
  callback = function()
    vim.api.nvim_command('bdelete!')
  end,
})
