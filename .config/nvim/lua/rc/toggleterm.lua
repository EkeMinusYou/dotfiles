require("toggleterm").setup()

-- See https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
local Terminal = require('toggleterm.terminal').Terminal

local k9s = Terminal:new({
	cmd = "k9s --readonly",
	hidden = true,
	direction = "float",
})

local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "float"
})

function Toggle_lazygit()
	lazygit:toggle()
end

function Toggle_k9s()
	k9s:toggle()
end
