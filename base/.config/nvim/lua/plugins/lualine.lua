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

-- See: https://github.com/wojciech-kulik/xcodebuild.nvim?tab=readme-ov-file#-lualine-integration
local function xcodebuild_device()
  if vim.g.xcodebuild_platform == 'macOS' then
    return ' macOS'
  end

  local deviceIcon = ''
  if vim.g.xcodebuild_platform:match('watch') then
    deviceIcon = '􀟤'
  elseif vim.g.xcodebuild_platform:match('tv') then
    deviceIcon = '􀡴 '
  elseif vim.g.xcodebuild_platform:match('vision') then
    deviceIcon = '􁎖 '
  end

  if vim.g.xcodebuild_os then
    return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name .. ' (' .. vim.g.xcodebuild_os .. ')'
  end

  return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'lewis6991/gitsigns.nvim' },
  event = 'VimEnter',
  config = function()
    require('lualine').setup({
      extensions = {
        'aerial',
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
            'filename',
            path = 0,
            symbols = { modified = '󰷥', readonly = ' ', newfile = '󰄛' },
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
          { "' ' .. vim.g.xcodebuild_last_status", color = { fg = 'Gray' } },
          { "'󰙨 ' .. vim.g.xcodebuild_test_plan", color = { fg = '#a6e3a1', bg = '#161622' } },
          { xcodebuild_device, color = { fg = '#f9e2af', bg = '#161622' } },
          {
            lsp_clients,
            separator = { left = '', right = '' },
          },
          {
            'diff',
            colored = true,
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            separator = { left = '', right = '' },
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
            path = 1,
            shorting_target = 24,
          },
        },
        lualine_b = {
          {
            require('plugins.lualine.cc-component'),
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
