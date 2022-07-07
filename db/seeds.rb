# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Rails.application.eager_load!

Work.create(
  name: "SQLトライアル編",
  slug: "trial",
  description: "SQLトライアル編です。",
  enabled: true,
  published: true
)
Chapter.create(
  work_id: 1,
  name: "トライアル"
)
Practice.create(
  chapter_id: 1,
  name: "SQLトライアル1",
  question: "出版年(release_year)が不明の書籍一覧を取得してください。",
  answer: "SELECT * FROM books WHERE release_year IS NULL;",
  sample_database_uid: 1,
  display_er_diagram: true,
  enabled: true,
  published: true,
  requires_auth: false
)
Practice.create(
  chapter_id: 1,
  name: "SQLトライアル2",
  question: "書籍一覧をページ数が多い順に並び替えてください。",
  answer: "SELECT name AS 書籍名, total_page AS 総ページ数 FROM books ORDER BY total_page DESC;",
  sample_database_uid: 1,
  display_er_diagram: true,
  enabled: true,
  published: true,
  requires_auth: false
)
Practice.create(
  chapter_id: 1,
  name: "SQLトライアル3",
  question: "書籍一覧をカテゴリー毎に集計して多い順に並び替え、上位３つを取得してください。",
  answer: "SELECT cat.name AS カテゴリー名, COUNT(book.name) AS 書籍数 FROM categories AS cat INNER JOIN book_categories AS book_cat ON cat.id = book_cat.category_id INNER JOIN books AS book ON book_cat.book_id = book.id GROUP BY カテゴリー名 ORDER BY 書籍数 DESC, カテゴリー名 ASC LIMIT 3;",
  sample_database_uid: 1,
  display_er_diagram: true,
  enabled: true,
  published: true,
  requires_auth: false
)
Practice.create(
  chapter_id: 1,
  name: "SQLトライアル4",
  question: "idが1のデータを削除後、イベント一覧を取得してください。",
  answer: "DELETE FROM events WHERE id = 1;\nSELECT * FROM events;",
  sample_database_uid: 1,
  display_er_diagram: false,
  enabled: true,
  published: true,
  requires_auth: false
)
SampleTable.create(practice_id: 1, uid: 2)
SampleTable.create(practice_id: 2, uid: 2)
SampleTable.create(practice_id: 3, uid: 1)
SampleTable.create(practice_id: 3, uid: 2)
SampleTable.create(practice_id: 3, uid: 3)
