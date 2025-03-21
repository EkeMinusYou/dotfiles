return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = '*',
  opts = {
    provider = 'custom-vertex',
    vendors = {
      ollama = {
        endpoint = 'http://192.168.1.9:11434',
        model = 'gemma3',
      },
      ['custom-vertex'] = {
        __inherited_from = 'vertex',
        model = 'gemini-2.0-flash-001',
        ---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
        parse_curl_args = function(opts, code_opts)
          local M = opts
          local P = require('avante.providers')
          local prompt_opts = code_opts

          local provider_conf, request_body = P.parse_config(M)
          local location = vim.fn.getenv('VERTEX_LOCATION')
          local project_id = vim.fn.getenv('VERTEX_PROJECT')
          local model_id = provider_conf.model or 'default-model-id'
          if location == nil or location == vim.NIL then
            location = 'us-central1'
          end
          if project_id == nil or project_id == vim.NIL then
            project_id = 'mineo-home'
          end
          local url = provider_conf.endpoint:gsub('LOCATION', location):gsub('PROJECT_ID', project_id)

          url = string.format('%s/%s:streamGenerateContent?alt=sse', url, model_id)

          request_body = vim.tbl_deep_extend('force', request_body, {
            generationConfig = {
              temperature = request_body.temperature,
              maxOutputTokens = request_body.max_tokens,
            },
          })
          request_body.temperature = nil
          request_body.max_tokens = nil
          local bearer_token = M.parse_api_key()

          local gemini_parse_messages = require('avante.providers.gemini').parse_messages

          return {
            url = url,
            headers = {
              ['Authorization'] = 'Bearer ' .. bearer_token,
              ['Content-Type'] = 'application/json; charset=utf-8',
            },
            proxy = provider_conf.proxy,
            insecure = provider_conf.allow_insecure,
            body = vim.tbl_deep_extend('force', {}, gemini_parse_messages(M, prompt_opts), request_body),
          }
        end,
      },
    },
  },
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
