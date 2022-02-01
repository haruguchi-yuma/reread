# frozen_string_literal: true

module ApplicationHelper
  def last_update_of_photo(book)
    return '' unless book.photos.exists?
    "#{l(book.photos.last.updated_at, format: :date)}" \
    + "(#{time_ago_in_words(book.photos.last.updated_at)}前)"
  end
end
