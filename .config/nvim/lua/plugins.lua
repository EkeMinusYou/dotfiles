vim.cmd.packadd('vim-jetpack')

require('jetpack.packer').add {
  { 'tani/vim-jetpack', opt = 1 },

  -- lsp
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { "hrsh7th/cmp-nvim-lsp" },

  -- treesitter
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context', requires = { 'nvim-treesitter/nvim-treesitter' } },
  { 'p00f/nvim-ts-rainbow' },
  { 'lukas-reineke/indent-blankline.nvim', requires = { 'nvim-treesitter/nvim-treesitter' } },

  -- explorer
  { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }, tag = '0.1.x' },

  -- keybinding
  { 'folke/which-key.nvim' },

  -- theme plugins
  { 'folke/tokyonight.nvim' },
  { 'christianchiarulli/nvcode-color-schemes.vim' },
  { 'glepnir/zephyr-nvim' },
}

require('rc.lsp')
require('rc.nvim-tree')
require('rc.nvim-treesitter')
require('rc.indent-blankline')
require('rc.lualine')
