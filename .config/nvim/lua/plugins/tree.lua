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
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      update_focused_file = { enable = true, update_root = true },
      view = {
        width = 40,
        mappings = {
          list = {
            { key = 'l', action = 'edit' },
            { key = 'h', action = 'close_node' },
            { key = 'C', action = 'cd' },
          },
        },
      },
    })
  end,
}
