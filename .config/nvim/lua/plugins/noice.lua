return {
  {
    'rcarriga/nvim-notify',
    lazy = true,
    config = function()
      require('notify').setup({
        top_down = false,
        background_colour = '#000000',
      })
    end,
  },
  {
    'folke/noice.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    event = 'VeryLazy',
    config = function()
      -- See https://github.com/folke/noice.nvim#-installation
      require('noice').setup({
        messages = {
          view = 'mini',
        },
        -- See: https://github.com/neovim/nvim-lspconfig/issues/1931
        routes = {
          {
            filter = {
              event = 'notify',
              find = 'No information available',
            },
            opts = {
              skip = true,
            },
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
  },
}
