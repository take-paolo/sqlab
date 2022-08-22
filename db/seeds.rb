# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Rails.application.eager_load!

Work.find_or_create_by(
  id: 1,
  name: "SQLトライアル編",
  slug: "trial",
  description: "SQLトライアル編です。",
  enabled: true,
  published: true
)
Chapter.find_or_create_by(
  id: 1,
  work_id: 1,
  name: "トライアル"
)
Practice.find_or_create_by(
  id: 1,
  chapter_id: 1,
  name: "SQLトライアル1",
  question: "出版年(release_year)が不明の書籍一覧を取得してください。",
  answer: "SELECT *\nFROM books\nWHERE release_year IS NULL;",
  sample_database_id: 1,
  display_er_diagram: true,
  enabled: true,
  published: true,
  requires_auth: false
)
Practice.find_or_create_by(
  id: 2,
  chapter_id: 1,
  name: "SQLトライアル2",
  question: "書籍一覧をページ数が多い順に並び替えてください。",
  answer: "SELECT name AS 書籍名, total_page AS 総ページ数\nFROM books\nORDER BY total_page DESC;",
  sample_database_id: 1,
  display_er_diagram: true,
  enabled: true,
  published: true,
  requires_auth: false
)
Practice.find_or_create_by(
  id: 3,
  chapter_id: 1,
  name: "SQLトライアル3",
  question: "書籍一覧をカテゴリー毎に集計して多い順に並び替え、上位３つを取得してください。",
  answer: "SELECT cat.name AS カテゴリー名, COUNT(book.name) AS 書籍数\nFROM categories AS cat\nINNER JOIN book_categories AS book_cat\nON cat.id = book_cat.category_id\nINNER JOIN books AS book\nON book_cat.book_id = book.id\nGROUP BY カテゴリー名\nORDER BY 書籍数 DESC, カテゴリー名 ASC\nLIMIT 3;",
  sample_database_id: 1,
  display_er_diagram: true,
  enabled: true,
  published: true,
  requires_auth: false
)
Practice.find_or_create_by(
  id: 4,
  chapter_id: 1,
  name: "SQLトライアル4",
  question: "idが1のデータを削除後、イベント一覧を取得してください。",
  answer: "DELETE FROM events\nWHERE id = 1;\nSELECT *\nFROM events;",
  sample_database_id: 1,
  display_er_diagram: false,
  enabled: true,
  published: true,
  requires_auth: false
)
SampleTable.find_or_create_by(id:1, practice_id: 1, uid: 2)
SampleTable.find_or_create_by(id:2, practice_id: 2, uid: 2)
SampleTable.find_or_create_by(id:3, practice_id: 3, uid: 1)
SampleTable.find_or_create_by(id:4, practice_id: 3, uid: 2)
SampleTable.find_or_create_by(id:5, practice_id: 3, uid: 3)
SampleTable.find_or_create_by(id:6, practice_id: 4, uid: 6)

Work.find_or_create_by(
  id: 2,
  name: "SQL初級編",
  slug: "basic",
  description: "SQLの基本であるSELECT文やWHERE句、データの検索条件を指定するための算術演算子、比較演算子、論理演算子に関する練習問題に取り組むことができます。",
  enabled: false,
  published: true
)
Work.find_or_create_by(
  id: 3,
  name: "SQL中級編",
  slug: "intermediate",
  description: "集約関数やデータのグループ化・並び替え、データの登録・更新・削除、サブクエリやJOIN句に関する練習問題に取り組むことができます。",
  enabled: false,
  published: true
)
Work.find_or_create_by(
  id: 4,
  name: "SQL上級編",
  slug: "advanced",
  description: "準備中...",
  enabled: false,
  published: true
)
Work.find_or_create_by(
  id: 5,
  name: "SQLチャレンジ編",
  slug: "challenge",
  description: "SQLの基礎力を試したい方は、チャレンジ問題に挑戦してみましょう！\nSQLのスキルがより上達することでしょう！",
  enabled: false,
  published: true
)
