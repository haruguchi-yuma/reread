# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    sequence(:title) { |i| "Book#{i}" }
    association :user
  end
end
