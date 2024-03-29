return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require('alpha')
    local startify = require('alpha.themes.startify')
    startify.section.top_buttons.val = {}
    startify.section.header.val = {
      [[	                                                                                         	]],
      [[	███╗   ███╗██╗███╗   ██╗███████╗ ██████╗ ███████╗███╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗	]],
      [[	████╗ ████║██║████╗  ██║██╔════╝██╔═══██╗██╔════╝████╗  ██║██╔════╝ ██║████╗  ██║██╔════╝	]],
      [[	██╔████╔██║██║██╔██╗ ██║█████╗  ██║   ██║█████╗  ██╔██╗ ██║██║  ███╗██║██╔██╗ ██║█████╗	  ]],
      [[	██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ██║   ██║██╔══╝  ██║╚██╗██║██║   ██║██║██║╚██╗██║██╔══╝	  ]],
      [[	██║ ╚═╝ ██║██║██║ ╚████║███████╗╚██████╔╝███████╗██║ ╚████║╚██████╔╝██║██║ ╚████║███████╗	]],
      [[	╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝	]],
      [[	                                                                                         	]],
    }
    alpha.setup(startify.config)
  end,
}
