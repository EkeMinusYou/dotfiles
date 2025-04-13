return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'pmizio/typescript-tools.nvim',
      'b0o/schemastore.nvim',
      'rachartier/tiny-inline-diagnostic.nvim',
      'nvim-java/nvim-java',
    },
    config = function()
      require('mason').setup()
      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup({
        ensure_installed = {
          'bashls',
          'dockerls',
          'jsonls',
          'lua_ls',
          'denols',
          'biome',
          'terraformls',
          'yamlls',
        },
        automatic_installation = true,
      })

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities({
        workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
      })
      -- Setup LSP
      lspconfig.sourcekit.setup({
        -- ref: https://www.swift.org/documentation/articles/zero-to-swift-nvim.html
        capabilities = capabilities,
        root_dir = function(filename, _)
          local util = require('lspconfig.util')
          -- prefer Package.swift for multi module with swift package manager
          return util.root_pattern('Package.swift')(filename)
            or util.root_pattern('buildServer.json', '*.xcodeproj')(filename)
            or vim.fs.dirname(vim.fs.find('.git', { path = filename, upward = true })[1])
        end,
      })
      lspconfig.atlas.setup({
        capabilities = capabilities,
      })

      -- Setup LSP by mason
      mason_lspconfig.setup_handlers({
        function(server_name)
          if server_name == 'lua_ls' then
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                },
              },
            })
          elseif server_name == 'helm_ls' then
            lspconfig.helm_ls.setup({
              capabilities = capabilities,
              root_dir = function(fname)
                return lspconfig.util.root_pattern('Chart.yaml')(fname)
              end,
            })
          elseif server_name == 'ts_ls' then
            -- do nothing. used by typescript-tools.nvim
            lspconfig.ts_ls.setup({
              -- typescript-toolsの方に任せるので、diagnosticsを無効化
              handlers = {
                ['textDocument/publishDiagnostics'] = function() end,
              },
              on_attach = function(client)
                client.server_capabilities.hoverProvider = false
                client.server_capabilities.completionProvider = false
                client.server_capabilities.diagnosticProvider = false
                client.server_capabilities.codeActionProvider = false
                client.server_capabilities.referencesProvider = false
                client.server_capabilities.definitionProvider = false
              end,
            })
          elseif server_name == 'denols' then
            lspconfig.denols.setup({
              capabilities = capabilities,
              root_dir = function(fname)
                return lspconfig.util.root_pattern('deno.json', 'deno.lock')(fname)
              end,
            })
          elseif server_name == 'biome' then
            lspconfig.biome.setup({
              capabilities = capabilities,
              root_dir = function(fname)
                return lspconfig.util.root_pattern('biome.json')(fname)
              end,
            })
          elseif server_name == 'stylelint_lsp' then
            lspconfig.stylelint_lsp.setup({
              cmd = { 'stylelint-lsp', '--stdio', '**/{*.css,*vue,*js,*.jsx,*ts,*.tsx,*.html}' },
              capabilities = capabilities,
              filetypes = {
                'css',
                'scss',
                'less',
                'sass',
                'html',
                'vue',
                'javascript',
                'javascriptreact',
                'typescript',
                'typescriptreact',
              },
            })
          elseif server_name == 'tailwindcss' then
            lspconfig.tailwindcss.setup({
              capabilities = capabilities,
              settings = {
                tailwindCSS = {
                  classAttributes = { 'class', 'class:list', 'classList', 'ngClass' }, -- className is configured by classRegex
                  experimental = {
                    classRegex = {
                      'className\\s*=\\s*["\']([^"\']*)["\']',
                      '(?<=clsx\\((?:[^`]|`[^`]*`)*?)[\'"]([^\'"]*)[\'"]',
                      '(?<=cva\\((?:[^`]|`[^`]*`)*?)[\'"]([^\'"]*)[\'"]',
                    },
                  },
                },
              },
            })
          elseif server_name == 'terraformls' then
            -- Workaround: https://github.com/neovim/neovim/issues/30675#issuecomment-2481410669
            lspconfig.terraformls.setup({
              offset_encoding = 'utf-8',
              capabilities = capabilities,
            })
          elseif server_name == 'jsonls' then
            lspconfig.jsonls.setup({
              capabilities = capabilities,
              settings = {
                json = {
                  schemas = require('schemastore').json.schemas(),
                  validate = { enable = true },
                },
              },
            })
          elseif server_name == 'yamlls' then
            lspconfig.yamlls.setup({
              capabilities = capabilities,
              settings = {
                yaml = {
                  schemaStore = {
                    enable = false,
                    url = '',
                  },
                  schemas = require('schemastore').yaml.schemas(),
                },
              },
            })
          elseif server_name == 'typos_lsp' then
            lspconfig.typos_lsp.setup({
              capabilities = capabilities,
              init_options = {
                config = '~/.config/typos/typos.toml',
              },
            })
          elseif server_name == 'markdown_oxide' then
            lspconfig.markdown_oxide.setup({
              capabilities = capabilities,
              root_dir = function(fname, _)
                return require('lspconfig').util.root_pattern('.projectroot', '.git', '.moxide.toml')(fname)
              end,
            })
          elseif server_name == 'jdtls' then
            require('java').setup()
            lspconfig.jdtls.setup({
              capabilities = capabilities,
            })
          else
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end
        end,
      })
    end,
  },
  {
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          'luvit-meta/library',
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    keys = {
      { '<leader>lr', '<cmd>Lspsaga finder<cr>' },
      { 'gn', '<cmd>Lspsaga rename<cr>' },
      { 'gt', '<cmd>Lspsaga goto_type_definition<cr>' },
      { 'K', '<cmd>Lspsaga hover_doc<cr>' },
      { 'ga', '<cmd>Lspsaga code_action<cr>' },
    },
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = {
          enable = false,
        },
        lightbulb = {
          enable = false,
        },
        outline = {
          enable = false,
        },
        rename = {
          auto_save = true,
        },
      })
    end,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    lazy = true,
    config = function()
      require('tiny-inline-diagnostic').setup({
        options = {
          show_source = true,
          use_icons_from_diagnostic = true,
          multilines = {
            enabled = true,
            always_show = true,
          },
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
