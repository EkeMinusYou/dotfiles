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

コミットメッセージは変更内容を参考に記載します。

コミットの変更内容は以下のコマンドを実行することで取得できます。


```shell
git  --no-pager diff
```

既に変更内容をステージした後であれば以下のコマンドを使ってください。

```shell
git --no-pager diff --staged
```


コミットメッセージは、`prefix(scope): description` のように、必ずprefix/scope/descriptionを記載してください。

prefixは以下から変更内容に応じて一つ選んでください。

- feat: A new feature
- fix: A bug fix
- docs: Documentation only changes
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- refactor: A code change that neither fixes a bug nor adds a feature
- perf: A code change that improves performance
- test: Adding missing or correcting existing tests
- chore: Changes to the build process or auxiliary tools and libraries such as documentation generation


scopeの例:

```
zshrc
nvim
lazygit
```

コミットメッセージの例:

```
fix(nvim/filetype): added `.clinerules` pattern
chore(nvim): update deps
feat(codecompanion): added codecompanion.nvim
```

## リポジトリ概要

README.md(../README.md) を参照してください。
