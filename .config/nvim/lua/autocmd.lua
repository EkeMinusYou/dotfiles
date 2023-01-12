vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.go' },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help' },
  callback = function()
    vim.api.nvim_command('wincmd L')
  end,
})

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

vim.api.nvim_create_autocmd('BufEnter', { callback = set_root })
