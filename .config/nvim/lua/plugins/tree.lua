-- See https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
end

-- See https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/core/nvimtree.lua#L285
local function start_telescope(telescope_mode)
  local basedir = vim.fn.getcwd()

  local node = require('nvim-tree.api').tree.get_node_under_cursor()
  if node ~= nil then
    local abspath = node.link_to or node.absolute_path
    local is_folder = node.open ~= nil
    basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ':h')
  end

  require('telescope.builtin')[telescope_mode]({
    cwd = basedir,
  })
end

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  keys = {
    { '<leader>ee', '<cmd>NvimTreeToggle<cr>' },
    {
      '<leader>ef',
      function()
        start_telescope('find_files')
      end,
    },
    {
      '<leader>eg',
      function()
        start_telescope('live_grep')
      end,
    },
  },
  config = function()
    require('nvim-tree').setup({
      on_attach = on_attach,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      live_filter = {
        always_show_folders = false,
      },
    })
  end,
}
