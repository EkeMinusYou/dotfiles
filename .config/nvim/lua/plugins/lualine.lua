-- See: https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-diff
local function diff_source()
  ---@diagnostic disable-next-line: undefined-field
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'BufReadPost',
  config = function()
    vim.opt.laststatus = 3
    require('lualine').setup({
      extensions = {
        'nvim-tree',
        'toggleterm',
        'trouble',
        'mason',
        'fzf',
      },
      options = {
        globalstatus = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      tabline = {
        lualine_a = {
          'mode',
        },
        lualine_b = {
          {
            'buffers',
            symbols = { modified = ' 󰷥', alternate_file = ' ', directory = ' ' },
          },
        },
        lualine_x = {
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            source = diff_source,
          },
        },
        lualine_y = {
          'branch',
        },
      },
      sections = {
        lualine_a = {
          {
            'filename',
            path = 0,
            symbols = { modified = '󰷥', readonly = ' ', newfile = '󰄛' },
          },
        },
        lualine_b = {
          {
            'filename',
            path = 1,
            shorting_target = 24,
          },
        },
        lualine_c = {},
        lualine_x = {
          'encoding',
        },
        lualine_y = {
          'filetype',
        },
        lualine_z = {
          { 'fileformat', icons_enabled = true, separator = { left = '', right = '' } },
        },
      },
    })
  end,
}
