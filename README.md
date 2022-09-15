# SQLab
![sqlab@2x-min](https://user-images.githubusercontent.com/42969542/190332661-cd02052e-f7b7-4ea6-9115-3ceee5ac9997.png)

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
1. お好きな問題集を選択します
2. 解きたい練習問題を選択します
3. 問題文を読み、クエリをエディタに記述します
4. 答え合わせボタンで正誤判定を行います

正解するまで3〜4を繰り返しましょう！

![demo](https://user-images.githubusercontent.com/42969542/190333151-d1c4ad7a-3d31-41d0-8bcc-eddd1b8aaa56.gif)

## 工夫した点
| タブアイテムのオートフォーカス機能 | 実行結果タブへのオートスライド機能 |
| ---- | ---- |
| ![auto_focus](https://user-images.githubusercontent.com/42969542/190333592-662efcac-ab44-4f0a-84f4-0692aa22c74d.gif) | ![auto_slide](https://user-images.githubusercontent.com/42969542/190333643-e00e7490-49bf-4757-878b-145ed26d1443.gif) |
| タブが切り替わると自動的にタブアイテムをフォーカスします。 | ユーザーが「実行」または「答え合わせ」ボタンを押した時に「実行結果」タブへ自動的にスライドします。 |

| ショートカット機能 | 演習画面の設定機能 |
| ---- | ---- |
| ![shortcut](https://user-images.githubusercontent.com/42969542/190337899-2c19b887-9599-4075-8887-a5ef164496df.gif) | ![settings](https://user-images.githubusercontent.com/42969542/190333903-c5aa0afa-663f-4280-8fe3-69a3946f2a93.gif) |
| タブの切り替えやクエリ実行、解答例の表示などをコマンド一つで実行できます。 | 実行結果タブへのオートスライド機能やショートカット機能のオンオフを切り替えることができます。 |

## その他機能
| 練習問題のお気に入り登録機能 | ログイン機能 |
| ---- | ---- |
| ![favorite](https://user-images.githubusercontent.com/42969542/190334665-3166d43b-d0ee-4c86-a1ff-08d106a79321.gif) | ![login](https://user-images.githubusercontent.com/42969542/190337722-1bd2f513-bd96-4674-854b-395ee11874b7.gif) |
| ログインユーザーは練習問題をお気に入り登録することができます。お気に入り登録一覧はマイページで確認することができます。 | GoogleまたはGitHubアカウントを用いてアカウント登録・ログインをすることができます。 |

| マイページ機能 | 管理画面機能 |
| ---- | ---- |
| ![mypage](https://user-images.githubusercontent.com/42969542/190334948-cc5ee277-d02a-431e-a35d-3106c7539ed4.gif) | ![admin_works](https://user-images.githubusercontent.com/42969542/190334984-819d33ad-6fc9-423b-a442-0304e83adfa6.gif) |
| マイページでアカウント登録情報の詳細や更新ができます。<br>また、お気に入り登録した練習問題の確認やお気に入り登録の解除をすることができます。 | 問題集・チャプター・練習問題を管理画面上で作成・更新・削除することができます。<br>また、ドラッグ&ドロップで並び順を任意のタイミングで入れ替えることができます。 |

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

### コード解析ツール
- ESLint
- Rubocop

### コードフォーマッター
- Prettier

### テスト
- Rspec

### インフラ
- Heroku
- PostgreSQL

## ER図
![er-diagram](https://user-images.githubusercontent.com/42969542/187009732-86a4f3f5-d3f9-4ccc-a350-7f4d8b0c5e4c.png)

## 関連記事
- [SQLの練習ができる学習サービス「SQLab」を作ってみた](https://qiita.com/paolo_takechi/items/6b69767d8efbd013bf64)
