FactoryBot.define do
  factory :user do
    provider { 'github' }
    sequence(:uid) { |i| "uid#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg"}
  end
end
