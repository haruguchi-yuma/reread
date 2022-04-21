# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :read_histories, dependent: :destroy

  paginates_per 10

  validates :title, length: { maximum: 50 }, presence: true
  validates :user, presence: true

  def last_update_of_photo
    return '' unless photos.exists?

    last_updated_photo = photos.order(updated_at: :desc).first
    I18n.l(last_updated_photo.updated_at, format: :date).to_s \
      + "(#{ApplicationController.helpers.time_ago_in_words(last_updated_photo.updated_at)}前)"
  end
end
