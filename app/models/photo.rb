# frozen_string_literal: true

class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :book

  validates_presence_of :image, message: 'を選択してください'
end
