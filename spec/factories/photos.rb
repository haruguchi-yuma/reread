# frozen_string_literal: true

FactoryBot.define do
  factory :photo do
    image do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec/factories/test_640x320.png'),
        'image/png'
      )
    end
    association :book

    trait :within_file_size do
      image do
        Rack::Test::UploadedFile.new(
          Rails.root.join('spec/factories/test_5MB.jpg'),
          'image/jpeg'
        )
      end
    end

    trait :over_file_size do
      image do
        Rack::Test::UploadedFile.new(
          Rails.root.join('spec/factories/test_6MB.jpg'),
          'image/jpeg'
        )
      end
    end

    trait :pdf do
      image do
        Rack::Test::UploadedFile.new(
          Rails.root.join('spec/factories/test.pdf'),
          'application/pdf'
        )
      end
    end
  end
end
