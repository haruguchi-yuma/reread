# frozen_string_literal: true

class ReadHistory < ApplicationRecord
  belongs_to :book
  validates :summary, length: { maximum: 50 }, presence: true
  validates :description, length: { maximum: 300 }
  validates :read_back_on, :book, presence: true
  validate :date_to_read_back_should_be_after_today

  private

  def date_to_read_back_should_be_after_today
    return unless read_back_on

    errors.add(:read_back_on, 'は今日より後の日付に設定してください') if read_back_on <= Time.zone.today
  end
end
