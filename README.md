# re:Read
![image](https://user-images.githubusercontent.com/57053236/167611378-13d332a3-49ed-45d2-ac52-a1486c8e33ce.png)
`re:Read`は技術書を読み返すための読書管理アプリです。

技術書などを何度も読み返したいが管理しきれず1度読んで、次を無ことを忘れてしまうといった問題を解決します。そのため以下のような特徴があります。
## 特徴
- 読み返したい本の内容を「気になりポイント」として写真で投稿する
- 「気になりポイント」にはメモを残すことができる
- 次に読み返す日をGoogleカレンダーに登録することができる


## 開発環境
- Ruby 3.1.0
- Rails 7.0.2

## 機能概要
- Googleアカウントでのみログインが可能です。
- 読み返したい本を登録することで、その書籍に紐づいた写真の投稿、読み返し日の設定ができます。
- 投稿した気になりポイント（写真）には140字以内でメモを残すことができます。
- 自分が投稿した気になりポイント（写真）や読み返したい本の情報は他のユーザからは見ることができません。

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
#### 読み返したい本のリスト
![image](https://user-images.githubusercontent.com/57053236/159635051-a7472660-c4f3-41e8-9ba1-46948bf6cb2a.png)

#### 読み返したい本の登録
![image](https://user-images.githubusercontent.com/57053236/167613240-ba4c990a-ace9-44e7-87e3-87a0cc5a524c.png)

#### 気になりポイントの一覧
![スクリーンショット 2022-05-10 19 51 56](https://user-images.githubusercontent.com/57053236/167612664-4ca0797e-12be-4f42-8606-6cbcd13e50fd.png)

#### 気になりポイント詳細
![image](https://user-images.githubusercontent.com/57053236/167613442-9b85c0df-b9e4-42c8-a32d-2b75fb356f6c.png)

#### 読み返す日の設定
![image](https://user-images.githubusercontent.com/57053236/167612994-d46202f1-3276-43b3-ba4c-fe52fb369f74.png)
