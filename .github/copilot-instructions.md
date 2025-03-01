# AI Coding ベストプラクティス

## はじめに

これは、AI が参照するドキュメントです。このリポジトリのファイルを変更する際のベストプラクティスを記載します。

## Git ワークフロー

このリポジトリにおける基本的なワークフローを説明します。

### ブランチ戦略

- mainブランチのみで運用する
- main以外のブランチを作成しない

### コミット

コミットは、意味のある単位で分割して、行います。複数の目的が混ざったコミットをしてはいけません。

### コミットメッセージ

コミットメッセージは、[Conventional Commits](https://www.conventionalcommits.org/ja/v1.0.0/) 及び [AngulerのCommit Message Guidelines](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines)に準拠します。

以下のいずれかのprefixを必ず付けてください。

- feat: A new feature
- fix: A bug fix
- docs: Documentation only changes
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- refactor: A code change that neither fixes a bug nor adds a feature
- perf: A code change that improves performance
- test: Adding missing or correcting existing tests
- chore: Changes to the build process or auxiliary tools and libraries such as documentation generation

変更対象のスコープ及び変更内容の説明を`prefix(scope): description`のように表現してください。

変更内容は以下のコマンドを実行して、適切な説明を表記してください。

```shell
git diff --staged
```

ステージする前であれば以下のコマンドを使ってください。

```shell
git diff
```

コミットメッセージの例:

```
fix(nvim/filetype): added `.clinerules` pattern
chore(nvim): update deps
feat(codecompanion): added codecompanion.nvim
```

## リポジトリ概要

README.md(../README.md) を参照してください。
