# frozen_string_literal: true

FactoryBot.define do
  factory :read_history do
    summary { 'MyString' }
    description { 'MyText' }
    history { '2022-02-10' }
    book { nil }
  end
end
