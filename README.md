# reRead
`reRead`は技術書を読み返すための読書管理アプリです。

技術書などを何度も読み返したいが管理しきれず1度読んで、次を無ことを忘れてしまうといった問題を解決します。そのため以下のような特徴があります。
## 特徴
- 書籍の内容を写真で投稿する
- 写真にはメモを残すことができる
- 次読み返す日をGoogleカレンダーに登録することができる


## 開発環境
- Ruby 3.1.0
- Rails 7.0.2

## 機能概要
- Googleアカウントでのみログインが可能です。
- 書籍を登録することで、その書籍に紐づいた写真の投稿、読み返し日の設定ができます。
- 投稿した写真には140字以内でメモを残すことができます。
- 自分が投稿した写真や書籍情報は他のユーザからは見ることができません。

## 利用方法
### 環境変数の設定
| 環境変数名 | 説明 |
| :-: | :-: |
| GOOGLE_CLIENT_ID | google client id |
| GOOGLE_CLIENT_SECRET | google client secret |

### インストール
```bash
$ bin/setup
$ bin/rails server
$ bin/webpack-dev-server
```

### Test/Formatter & Lint
```bash
$ bundle exec rspec
$ bin/lint
```

## スクリーンショット
### 画面
![image](https://user-images.githubusercontent.com/57053236/159634918-2b59fac5-da5e-4926-bd70-450cd5c57440.png)
![image](https://user-images.githubusercontent.com/57053236/159635051-a7472660-c4f3-41e8-9ba1-46948bf6cb2a.png)

![image](https://user-images.githubusercontent.com/57053236/159635140-3105188a-9847-475c-8c5e-649964bc2cda.png)

![image](https://user-images.githubusercontent.com/57053236/159635285-396d7767-cf3b-4c12-8c6c-aaf7e161ccd2.png)
