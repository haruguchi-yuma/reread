class Book < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 50 }, presence: true
end
