return {
  'wojciech-kulik/xcodebuild.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-tree.lua',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('xcodebuild').setup({})
  end,
}
