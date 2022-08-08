module ApplicationHelper
  def default_meta_tags
    {
      site: 'SQLab',
      title: 'SQLの練習ができる学習サービス',
      description: 'SQLの練習ができるSQL特化の学習サービスです。環境構築不要で豊富な練習問題に取り組むことができます。SQLabを活用してSQLの知識をスキルに変えていきましょう。',
      keywords: 'sqlab, sql, sql 練習, sql 演習, sql 問題, sql 勉強',
      charset: 'utf-8',
      separator: '|',
      reverse: true,
      canonical: request.original_url,
      icon: [
        { href: image_url('/favicon.ico') },
        { href: image_url('/apple-touch-icon-precomposed.png'), rel: 'apple-touch-icon-precomposed', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: :site,
        title: 'SQLの練習ができる学習サービス | SQLab',
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('/ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        title: 'SQLの練習ができる学習サービス | SQLab',
        description: :description,
        image: image_url('/ogp.png'),
        card: 'summary_large_image',
        site: '@sqlab_app'
      }
    }
  end
end
