# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Photos', type: :system do
  let(:user_a) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book, user: user_a) }

  describe '一覧表示機能' do
    let!(:photo) { FactoryBot.create(:photo, book: book) }

    context 'ユーザーAがログインしているとき' do
      it '投稿した写真が表示される' do
        sign_in_as user_a
        visit book_path(book)

        within ".image-#{photo.id}" do
          expect have_selector 'img'
        end
      end
    end

    context 'ユーザーBがログインしているとき' do
      it 'ユーザーAが投稿した写真は表示されない' do
        sign_in_as user_b
        visit book_path(book)

        expect(page).not_to have_selector ".image-#{photo.id}"
        expect(current_path).to eq books_path
      end
    end
  end

  describe '投稿機能' do
    before do
      sign_in_as user_a
      visit new_book_photos_path(book)
    end

    context 'ファイルを選択したとき' do
      it '投稿できる' do
        expect do
          attach_file '写真', "#{Rails.root}/spec/factories/test_640x320.png"
          click_on '投稿する'
        end.to change(book.photos, :count).by(1)

        expect(page).to have_selector '.notification', text: '写真を投稿しました'
      end
    end

    context 'ファイルを選択しなかったとき' do
      it 'エラーになる' do
        expect do
          click_on '投稿する'
        end.to change(book.photos, :count).by(0)
        within '#error_explanation' do
          expect(page).to have_content '写真が選択されていません'
        end
      end
    end
  end
end
