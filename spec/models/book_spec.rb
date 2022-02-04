require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'タイトル、ユーザーがあれば有効な状態であること' do
    user = User.create(
      provider: 'github',
      uid: 1_234_567,
      image_url: 'https://avatars.githubusercontent.com/u/57053236?v=4'
    )
    book = Book.new(title: 'book title', user: user)
    expect(book).to be_valid
  end

  it 'タイトルがなければ無効な状態であること' do
    book = Book.new(title: nil)
    book.valid?
    expect(book.errors[:title]).to include('を入力してください')
  end

  it 'タイトルが50文字より長ければ無効な状態であること' do
    book = Book.new(title: 'a' * 50)
    book.valid?
    expect(book.errors[:title]).not_to include('は50文字以内で入力してください')

    book = Book.new(title: 'a' * 51)
    book.valid?
    expect(book.errors[:title]).to include('は50文字以内で入力してください')
  end
end
