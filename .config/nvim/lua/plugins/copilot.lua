local function ShowCopilotChatActionPrompt()
  local actions = require('CopilotChat.actions')
  require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
end

local function CopilotChatBuffer()
  local input = vim.fn.input('Quick Chat: ')
  if input ~= '' then
    require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
  end
end

return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<M-;>',
            accept_word = '<M-->',
            accept_line = '<M-/>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
      })
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    keys = {
      {
        '<leader>ccp',
        function()
          ShowCopilotChatActionPrompt()
        end,
        mode = { 'n', 'v' },
      },
      {
        '<leader>ccb',
        function()
          CopilotChatBuffer()
        end,
        mode = { 'n', 'v' },
      },
    },
    config = function()
      local select = require('CopilotChat.select')
      require('CopilotChat').setup({
        window = {
          layout = 'float',
          relative = 'editor',
        },
        prompts = {
          Explain = {
            prompt = '/COPILOT_EXPLAIN 選択されたコードの説明を段落をつけて書いてください。',
          },
          Review = {
            prompt = '/COPILOT_REVIEW 選択されたコードをレビューしてください。',
            callback = function() end,
          },
          Fix = {
            prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き直してください。',
          },
          Optimize = {
            prompt = '/COPILOT_REFACTOR 選択されたコードを最適化してパフォーマンスと可読性を向上させてください。',
          },
          Docs = {
            prompt = '/COPILOT_DOCS 選択されたコードに対してドキュメンテーションコメントを追加してください。',
          },
          Tests = {
            prompt = '/COPILOT_TESTS 選択されたコードの詳細な単体テスト関数を書いてください。',
          },
          FixDiagnostic = {
            prompt = 'ファイル内の次のような診断上の問題を解決してください:',
            selection = select.diagnostics,
          },
        },
      })
    end,
  },
}
