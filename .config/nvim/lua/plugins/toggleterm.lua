local lazygit

function Toggle_lazygit()
	lazygit:toggle()
end

local k9s

function Toggle_k9s()
	k9s:toggle()
end

return {
	'akinsho/toggleterm.nvim',
	config = function()
		require("toggleterm").setup()

		-- See https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
		local Terminal = require('toggleterm.terminal').Terminal

		k9s = Terminal:new({
			cmd = "k9s --readonly",
			hidden = true,
			direction = "float",
		})

		lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float"
		})
	end
}
