local helper = require('utils.helper')

-- global
vim.g.mapleader = ' '
vim.g.termwinkey = '<C-g>'

-- emacs keybinding in insert-mode
vim.keymap.set('i', '<c-b>', '<left>')
vim.keymap.set('i', '<c-f>', '<right>')
vim.keymap.set('i', '<c-p>', '<up>')
vim.keymap.set('i', '<c-n>', '<down>')
vim.keymap.set('i', '<c-a>', '<c-o>0')
vim.keymap.set('i', '<c-e>', '<c-o>$')
vim.keymap.set('i', '<c-s>', '<cmd>update<cr>')
vim.keymap.set('i', '<m-b>', '<c-o>b')
vim.keymap.set('i', '<m-f>', '<c-o>w')

-- lsp
vim.keymap.set('n', 'gf', function()
  helper.lsp_formatting({ async = true, timeout_ms = 5000 })
end)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>')
vim.keymap.set('n', 'gi', function()
  require('telescope.builtin').lsp_implementations()
end)
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references()
end)
vim.keymap.set('n', '<leader>ld', function()
  require('telescope.builtin').diagnostics({ layout_strategy = 'vertical' })
end)
vim.keymap.set('i', '<c-k>', function()
  helper.lsp_formatting({ async = true, timeout_ms = 5000 })
end)

-- define by lspsaga
-- vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
-- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
-- vim.keymap.set({ 'n', 'v' }, 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')

-- kensaku
vim.keymap.set('c', '<CR>', '<Plug>(kensaku-search-replace)<CR>')

-- lazygit
-- See: https://chatgpt.com/share/674bf704-49fc-800a-815e-dc2a01d16439
vim.keymap.set({ 'n', 'v' }, '<leader>g', function()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.9),
    height = math.floor(vim.o.lines * 0.9),
    row = math.floor(vim.o.lines * 0.05),
    col = math.floor(vim.o.columns * 0.05),
    style = 'minimal',
    border = 'rounded',
  })

  local job_id = vim.fn.jobstart('lazygit', {
    term = true,
    on_exit = function()
      vim.cmd('NvimTreeRefresh')
      vim.api.nvim_win_close(win, true)
    end,
  })

  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.fn.jobstop(job_id)
    end,
  })
end, { noremap = true, silent = true })

-- serpl
vim.keymap.set('n', '<leader>s', function()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.9),
    height = math.floor(vim.o.lines * 0.9),
    row = math.floor(vim.o.lines * 0.05),
    col = math.floor(vim.o.columns * 0.05),
    style = 'minimal',
    border = 'rounded',
  })

  vim.fn.jobstart('serpl', {
    term = true,
    on_exit = function()
      vim.api.nvim_win_close(win, true)
    end,
  })
end, { noremap = true, silent = true })

-- yazi
vim.keymap.set('n', '<leader>y', function()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.9),
    height = math.floor(vim.o.lines * 0.9),
    row = math.floor(vim.o.lines * 0.05),
    col = math.floor(vim.o.columns * 0.05),
    style = 'minimal',
    border = 'rounded',
  })

  vim.fn.jobstart('yazi', {
    term = true,
    on_exit = function()
      vim.api.nvim_win_close(win, true)
    end,
  })
end, { noremap = true, silent = true })

-- k9s
vim.keymap.set('n', '<leader>k', function()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.9),
    height = math.floor(vim.o.lines * 0.9),
    row = math.floor(vim.o.lines * 0.05),
    col = math.floor(vim.o.columns * 0.05),
    style = 'minimal',
    border = 'rounded',
  })

  vim.fn.jobstart('k9s --readonly', {
    term = true,
    on_exit = function()
      vim.api.nvim_win_close(win, true)
    end,
  })
end, { noremap = true, silent = true })

-- See: https://zenn.dev/vim_jp/articles/2024-06-05-vim-middle-class-features#%E5%BC%95%E7%94%A8%E7%AC%A6%E3%81%A7%E5%9B%B2%E3%81%BE%E3%82%8C%E3%81%9F%E7%AE%87%E6%89%80%E5%85%A8%E4%BD%93%E3%82%92%E9%81%B8%E6%8A%9E%E3%81%99%E3%82%8B
for _, quote in ipairs({ '"', "'", '`' }) do
  vim.keymap.set({ 'x', 'o' }, 'a' .. quote, '2i' .. quote)
end

vim.api.nvim_set_keymap('o', 'i<Space>', 'iW', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'i<Space>', 'iW', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'F<cr>', '{', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'f<cr>', '}', { noremap = true, silent = true })

-- See: https://zenn.dev/vim_jp/articles/2024-10-07-vim-insert-uppercase
vim.keymap.set('i', '<C-o>', function()
  local line = vim.fn.getline('.')
  local col = vim.fn.getpos('.')[3]
  local substring = line:sub(1, col - 1)
  local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
  return '<C-w>' .. result:upper()
end, { expr = true })

local root_names = { '.git' }
local set_git_root = function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then
    return
  end
  path = vim.fs.dirname(path)

  local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
  if root_file == nil then
    return
  end
  local root = vim.fs.dirname(root_file)

  vim.cmd('cd ' .. root)
end

vim.keymap.set('n', '<leader>cr', set_git_root)

vim.keymap.set('i', '<C-@>', function()
  return require('utils.random-string').generate_random_phrase()
end, { expr = true, silent = true })
