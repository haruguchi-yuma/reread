# frozen_string_literal: true

FactoryBot.define do
  factory :read_history do
    summary { '本のタイトル' }
    read_back_on { Time.zone.tomorrow }
    description { '' }
    association :book

    trait :without_summary do
      summary { '' }
    end

    trait :without_read_back_on do
      read_back_on { '' }
    end

    trait :date_is_before_today do
      read_back_on { Time.zone.yesterday }
    end
  end
end
