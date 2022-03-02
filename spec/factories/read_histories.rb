# frozen_string_literal: true

FactoryBot.define do
  factory :read_history do
    summary { '本のタイトル' }
    read_back_at { Time.zone.today + 1.day }
    description { '' }
    association :book
  end
end
