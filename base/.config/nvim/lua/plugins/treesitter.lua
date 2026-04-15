local treesitter_languages = {
  'go',
  'hcl',
  'javascript',
  'styled',
  'typescript',
  'lua',
  'yaml',
}

local atlas_filetypes = {
  'atlas-config',
  'atlas-schema-mysql',
  'atlas-schema-postgresql',
  'atlas-schema-sqlite',
  'atlas-schema-clickhouse',
  'atlas-schema-mssql',
  'atlas-schema-redshift',
  'atlas-test',
  'atlas-plan',
}

local function start_treesitter(bufnr)
  if vim.bo[bufnr].buftype ~= '' then
    return
  end

  pcall(vim.treesitter.start, bufnr)
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      require('nvim-treesitter').install(treesitter_languages)

      -- See: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/atlas.lua
      vim.treesitter.language.register('hcl', atlas_filetypes)

      local group = vim.api.nvim_create_augroup('eke-treesitter-highlight', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        callback = function(args)
          start_treesitter(args.buf)
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'TSUpdate',
        callback = function()
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            start_treesitter(bufnr)
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local textobjects = require('nvim-treesitter-textobjects')
      local move = require('nvim-treesitter-textobjects.move')
      local select = require('nvim-treesitter-textobjects.select')
      local swap = require('nvim-treesitter-textobjects.swap')

      textobjects.setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      vim.keymap.set({ 'x', 'o' }, 'af', function()
        select.select_textobject('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        select.select_textobject('@function.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'aa', function()
        select.select_textobject('@parameter.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ia', function()
        select.select_textobject('@parameter.inner', 'textobjects')
      end)

      vim.keymap.set('n', '<leader>A', function()
        swap.swap_next('@parameter.inner')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
        move.goto_next_start('@class.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
        move.goto_next_end('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
        move.goto_next_end('@class.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
        move.goto_previous_start('@class.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
        move.goto_previous_end('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
        move.goto_previous_end('@class.outer', 'textobjects')
      end)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPost',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('treesitter-context').setup({})
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = 'BufReadPost',
    config = function()
      require('hlchunk').setup({
        chunk = {
          -- 有効にするとfreezeする
          enable = false,
          delay = 0,
        },
        line_num = {
          -- 有効にするとfreezeする
          enable = false,
        },
        blank = {
          enable = false,
        },
        indent = {
          enable = true,
          style = {
            '#E06C75',
            '#E5C07B',
            '#61AFEF',
            '#D19A66',
            '#98C379',
            '#C678DD',
            '#56B6C2',
          },
        },
      })
    end,
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup()
    end,
  },
}
