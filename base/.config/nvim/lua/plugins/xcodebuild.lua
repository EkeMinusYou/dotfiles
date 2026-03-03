return {
  'wojciech-kulik/xcodebuild.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('xcodebuild').setup({
      nvim_tree = {
        enabled = false,
      },
    })
  end,
}
