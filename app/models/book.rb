# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :title, length: { maximum: 50 }, presence: true
end
