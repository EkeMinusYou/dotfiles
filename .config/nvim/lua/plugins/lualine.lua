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

local function lsp_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if next(clients) == nil then
    return ''
  end
  local client_names = {}
  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end
  return table.concat(client_names, ', ')
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'lewis6991/gitsigns.nvim' },
  event = 'VimEnter',
  config = function()
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
            lsp_clients,
          },
          {
            'diff',
            colored = true,
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            separator = { left = '', right = '' },
            source = diff_source,
          },
        },
        lualine_y = {
          {
            'b:gitsigns_head',
            icon = { '' },
          },
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
          {
            'fileformat',
            icons_enabled = true,
            separator = { left = '', right = '' },
          },
        },
      },
    })
  end,
}
