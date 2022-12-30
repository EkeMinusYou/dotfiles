vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- See https://github.com/LunarVim/LunarVim/blob/9bc82e4e684aa548eb0765734ec4e83f16c78b4c/lua/lvim/core/nvimtree.lua#L143
local function start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode] {
    cwd = basedir,
  }
end

local function telescope_find_files(_)
  start_telescope "find_files"
end

local function telescope_live_grep(_)
  start_telescope "live_grep"
end

require("nvim-tree").setup({
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  update_focused_file = { enable = true, update_root = true },
  view = {
    width = 40,
    mappings = {
      list = {
        { key = "l", action = "edit" },
        { key = "h", action = "close_node" },
        { key = "C", action = "cd" },
        { key = "gtf", action = "telescope_find_files", action_cb = telescope_find_files },
        { key = "gtg", action = "telescope_live_grep", action_cb = telescope_live_grep },
      },
    },
  },
})
