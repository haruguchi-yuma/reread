# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    provider { 'google_oauth2' }
    sequence(:uid) { |i| "uid#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg" }
  end
end
