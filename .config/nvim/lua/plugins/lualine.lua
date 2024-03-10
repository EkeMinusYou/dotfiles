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
  dependencies = { 'nvim-tree/nvim-web-devicons', 'lewis6991/gitsigns.nvim' },
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
        lualine_c = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            sections = { 'error', 'warn', 'info', 'hint' },
            diagnostics_color = {
              error = 'DiagnosticError',
              warn = 'DiagnosticWarn',
              info = 'DiagnosticInfo',
              hint = 'DiagnosticHint',
            },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
        },
        lualine_x = {
          {
            'diff',
            colored = true,
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            source = diff_source,
          },
        },
        lualine_y = {
          { 'b:gitsigns_head', icon = { '' } },
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
