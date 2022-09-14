# SQLab
![sqlab](https://user-images.githubusercontent.com/42969542/186997705-e8ca3848-3cff-4734-8ae1-423a83bf188d.png)

サービスURL: https://sqlab.net

## サービス概要
SQLの練習ができるSQL特化の学習サービスです。<br>
練習問題が豊富で、環境構築不要！ブラウザ上ですぐにSQLを書いて結果を確認することができます。

## 強み
- 無料でバリエーション豊かな多くの練習問題に取り組める
- 環境構築不要でブラウザ上ですぐに実践できる
- シンプルなUI
- ER図やデータベース値を参考にしながらクエリを組み立てるのでより実践的に演習ができる

## こんな方におすすめ
- とにかく多くの問題を解いてSQLのスキルを高めたい方
- 有料の学習サービスを利用したが、もう少し難易度の高い練習問題を解いてみたい方
- SQLの技術書を読んだけど次に何をすれば良いかわからない方
- 実際にSQLを書いてみたいけど環境構築やデータの用意が面倒だなと感じる方

## 使い方
### 1. エディタにクエリを入力する

実行ボタンを押すと記述したクエリの実行結果を確認することができます。

![image](https://user-images.githubusercontent.com/42969542/187005239-0e75865d-f081-40de-a7ac-9c4b1807a025.png)

### 2. 答え合わせボタンで正誤判定を行う

想定結果に合わせて解答してください。正解するまでトライアンドエラーを繰り返しましょう！

![image](https://user-images.githubusercontent.com/42969542/187005524-3ef488fc-f517-4cd3-bba5-cb79c544e977.png)

## その他機能
|  タブアイテムのオートフォーカス機能  |  ショートカット機能  |
| ---- | ---- |
| ![gif](https://user-images.githubusercontent.com/42969542/187007091-5ad84f1c-aa15-4e7b-ba0b-932dc6e38ed5.gif) | ![image](https://user-images.githubusercontent.com/42969542/187007213-e4fe7fa0-208e-4da1-8255-de6d3c1cefa3.png) |
| タブが切り替わると自動的にタブアイテムをフォーカスします。 | タブの切り替えやクエリ実行、解答例の表示などをコマンド一つで実行できます。 |

|  演習画面の設定機能  |  練習問題のお気に入り登録機能  |
| ---- | ---- |
| ![image](https://user-images.githubusercontent.com/42969542/187007241-90d823b5-1169-4a72-bef5-cc9f1bdca875.png) | ![image](https://user-images.githubusercontent.com/42969542/187007749-0e627c4c-2a20-4530-9378-8de2679d9cca.png) |
| 実行結果タブへのオートスライド機能やショートカット機能のオンオフを切り替えることができます。 | ログインユーザーは練習問題をお気に入り登録することができます。お気に入り一覧はマイページで確認することができます。 |

|  ログイン機能  |  マイページ機能  |
| ---- | ---- |
| ![image](https://user-images.githubusercontent.com/42969542/187009051-b9553379-720a-4336-b7df-cc2cd1fffc32.png) | ![image](https://user-images.githubusercontent.com/42969542/187009132-731f5e56-9d65-4352-8ff8-9253ac084cb3.png) |
| GoogleまたはGitHubアカウントを用いてアカウント登録・ログインをすることができます。 | マイページでアカウント登録情報の確認やお気に入り登録した練習問題一覧を確認することができます。 |

|  アカウント設定機能  |  管理画面機能  |
| ---- | ---- |
| ![image](https://user-images.githubusercontent.com/42969542/187009198-8673a47b-62d3-4179-845a-5f0a4eb85b6f.png) | ![image](https://user-images.githubusercontent.com/42969542/187008928-c14c92c3-5b71-4dd8-a035-1cc843c6348f.png) |
| ユーザー名、メールアドレスを変更することができます。 | 問題集・チャプター・練習問題を管理画面上で作成・更新・削除することができます。また、ドラッグ&ドロップで並び順を入れ替えることができます。 |

## 使用技術
### フロントエンド
- HTML
- CSS
- SCSS
- JavaScript
- Vue.js (2.6.14)
- Vuetify (2.6.7)

### バックエンド
- Ruby (3.0.2)
- Rails (6.1.4.1)

### インフラ
- Heroku
- PostgreSQL

## ER図
![er-diagram](https://user-images.githubusercontent.com/42969542/187009732-86a4f3f5-d3f9-4ccc-a350-7f4d8b0c5e4c.png)
