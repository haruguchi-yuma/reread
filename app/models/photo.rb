# frozen_string_literal: true

class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :book

  validates :image, presence: { message: 'が選択されていません' }
end
