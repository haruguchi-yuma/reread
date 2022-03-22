# frozen_string_literal: true

module MetaTagsHelper
  # rubocop:disable Metrics/MethodLength
  def default_meta_tags
    {
      site: 're:Read',
      reverse: true,
      charset: 'utf-8',
      description: '技術書を読み返すための読書管理アプリ',
      canonical: 'https://reread-book.herokuapp.com/',
      viewport: 'width=device-width, initial-scale=1.0',
      og: {
        title: 're:Read',
        type: 'website',
        site_name: 're:Read',
        description: :description,
        image: image_url('ogp.png'),
        url: 'https://reread-book.herokuapp.com/',
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@haruguchiyuma',
        description: :description,
        domain: 'https://reread-book.herokuapp.com/'
      }
    }
  end
end
