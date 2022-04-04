# frozen_string_literal: true

class ReadHistory < ApplicationRecord
  belongs_to :book
  validates :summary, length: { maximum: 50 }, presence: true
  validates :description, length: { maximum: 300 }
  validates :read_back_at, :book, presence: true
  validate :date_to_read_back_should_be_after_today

  private

  def date_to_read_back_should_be_after_today
    return unless read_back_at

    errors.add(:read_back_at, 'は今日より後の日付に設定してください') if read_back_at <= Time.zone.today
  end
end
