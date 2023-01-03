require('lazy').setup {
	-- lsp
	{ 'neovim/nvim-lspconfig' },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/vim-vsnip" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },

	-- linter/formatter
	{ 'jose-elias-alvarez/null-ls.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

	-- coding support
	{ 'windwp/nvim-autopairs' },
	{ 'lewis6991/gitsigns.nvim' },
	{ 'machakann/vim-sandwich' },
	{ 'numToStr/Comment.nvim' },

	-- treesitter
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'lukas-reineke/indent-blankline.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' } },

	-- explorer
	{ 'nvim-tree/nvim-tree.lua', dependencies = { 'nvim-tree/nvim-web-devicons' } },

	-- statusline
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },

	-- bufferline
	{ 'akinsho/bufferline.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, version = 'v3.x' },

	-- finder
	{ 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, version = '0.1.x' },
	{ 'nvim-telescope/telescope-fzf-native.nvim',
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" }, build = 'make' },

	-- keybinding
	{ 'folke/which-key.nvim' },

	-- terminal
	{ 'akinsho/toggleterm.nvim' },

	-- theme
	{ 'folke/tokyonight.nvim' },
	{ 'christianchiarulli/nvcode-color-schemes.vim' },
	{ 'glepnir/zephyr-nvim' },

	-- notification
	{ 'folke/noice.nvim', dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' } },
	{ 'MunifTanjim/nui.nvim' },
	{ 'rcarriga/nvim-notify' },
	{ 'folke/trouble.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },

	-- dependencies
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'nvim-lua/plenary.nvim' },
}

require('rc.lsp')
require('rc.null-ls')
require('rc.gitsigns')
require('rc.comment')
require('rc.bufferline')
require('rc.nvim-tree')
require('rc.nvim-treesitter')
require('rc.indent-blankline')
require('rc.lualine')
require('rc.toggleterm')
require('rc.telescope')
require('rc.nvim-cmp')
require('rc.noice')
require('rc.nvim-autopairs')
require('rc.trouble')
