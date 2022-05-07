# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    sequence(:title) { |i| "Book#{i}" }
    user
  end
end
