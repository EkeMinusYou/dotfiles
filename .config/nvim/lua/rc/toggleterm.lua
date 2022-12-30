require("toggleterm").setup()

-- See https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float"
})

function Lazygit_toggle()
  lazygit:toggle()
end
