# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :read_histories, dependent: :destroy

  paginates_per 10

  validates :title, length: { maximum: 50 }, presence: true
  validates :user, presence: true
end
