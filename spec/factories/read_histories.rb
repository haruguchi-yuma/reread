# frozen_string_literal: true

FactoryBot.define do
  factory :read_history do
    summary { '本のタイトル' }
    read_back_on { Time.zone.tomorrow }
    description { '' }
    book
  end
end
