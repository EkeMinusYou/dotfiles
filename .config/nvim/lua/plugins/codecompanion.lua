return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('codecompanion').setup({
      opts = {
        system_prompt = function()
          return string.format(
            [[あなたは「CodeCompanion」という名前のAIプログラミングアシスタントです。現在、ユーザーのマシン上のNeovimテキストエディタに接続されています。

主なタスクは以下の通りです：

- 一般的なプログラミングに関する質問への回答。
- Neovimバッファ内のコードの動作説明。
- Neovimバッファ内で選択されたコードのレビュー。
- 選択されたコードに対するユニットテストの生成。
- 選択されたコードの問題に対する修正案の提案。
- 新しいワークスペース用のコードのスキャフォールディング。
- ユーザーのクエリに関連するコードの検索。
- テスト失敗に対する修正案の提案。
- Neovimに関する質問への回答。
- ツールの実行。

あなたは以下を厳守しなければなりません：

- ユーザーの要件に正確に従うこと。
- ユーザーのコンテキストがあなたの主要タスクの範囲外である場合、回答は簡潔かつ無機質にすること。
- 追加の文章は必要最低限に抑えること（明確化が必要な場合を除く）。
- 回答にはMarkdown形式を使用すること。
- 各Markdownコードブロックの冒頭にプログラミング言語名を含めること。
- コードブロック内に行番号を含めないこと。
- 回答全体をトリプルバッククォートで囲まないこと。
- 現在のタスクに直接関連するコードのみを返すこと。必要でないコードは省略してもよい。
- 回答には実際の改行を使用し、"\n"はリテラルなバックスラッシュと'n'としてのみ使用すること。
- コード以外の全てのテキストの回答は日本語で記述すること。

タスクが与えられた場合：

1. 手順を順を追って考え、ユーザーが特に要求しない限り、またはタスクが非常に単純でない限り、詳細な疑似コードで計画を説明すること。
2. 最終コードを1つのコードブロックに出力し、関連するコードのみを含むことを保証すること。
3. 回答の最後に、会話を継続するために直接サポートする短い提案を含めること。
4. 会話の各ターンごとに、1回の完全な返信を提供すること。]]
          )
        end,
      },
      display = {
        chat = {
          window = {
            layout = 'vertical',
            position = 'right',
            border = 'single',
            height = 0.8,
            width = 0.45,
            relative = 'editor',
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = '0',
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = 'no',
              spell = false,
              wrap = true,
            },
          },
        },
      },
      strategies = {
        chat = {
          adapter = 'ollama',
        },
        inline = {
          adapter = 'ollama',
        },
        agent = {
          adapter = 'ollama',
        },
      },
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://192.168.1.9:11434',
            },
            headers = {
              ['Content-Type'] = 'application/json',
            },
            parameters = {
              sync = true,
            },
            schema = {
              model = {
                default = 'deepseek-r1:14B',
              },
            },
          })
        end,
      },
    })
  end,
}
