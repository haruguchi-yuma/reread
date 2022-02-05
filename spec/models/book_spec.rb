# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it '有効なファクトリがあること' do
    expect(FactoryBot.build(:book)).to be_valid
  end

  it 'タイトルがなければ無効な状態であること' do
    book = FactoryBot.build(:book, title: nil)
    book.valid?
    expect(book.errors[:title]).to include('を入力してください')
  end

  it 'ユーザーがいなければ無効な状態であること' do
    book = FactoryBot.build(:book, user: nil)
    book.valid?
    expect(book.errors[:user]).to include('を入力してください')
  end

  it 'タイトルが50文字より長ければ無効な状態であること' do
    book = FactoryBot.build(:book, title: 'a' * 50)
    book.valid?
    expect(book.errors[:title]).not_to include('は50文字以内で入力してください')

    long_title_book = FactoryBot.build(:book, title: 'a' * 51)
    long_title_book.valid?
    expect(long_title_book.errors[:title]).to include('は50文字以内で入力してください')
  end
end
