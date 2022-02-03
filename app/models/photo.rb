# frozen_string_literal: true

class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :book

  validates :image, presence: { message: 'を選択してください' }
end
