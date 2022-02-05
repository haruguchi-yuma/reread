FactoryBot.define do
  factory :photo do
    image { 
      Rack::Test::UploadedFile.new(
        File.join(Rails.root, 'spec/factories/test_640x320.png'),
        'image/png'
      )
    }
    association :book

    trait :within_file_size do
      image { 
      Rack::Test::UploadedFile.new(
          File.join(Rails.root, 'spec/factories/test_5MB.jpg'),
          'image/jpeg'
        )
      }
    end

    trait :over_file_size do
      image { 
        Rack::Test::UploadedFile.new(
          File.join(Rails.root, 'spec/factories/test_6MB.jpg'),
          'image/jpeg'
        )
      }
    end

    trait :pdf do
      image { 
        Rack::Test::UploadedFile.new(
          File.join(Rails.root, 'spec/factories/test.pdf'),
          'application/pdf'
        )
      }
    end
  end
end
