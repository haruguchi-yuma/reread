# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Photos', type: :system do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let(:book) { create(:book, user: user_a) }

  describe '一覧表示機能' do
    let!(:photo) { create(:photo, book: book) }

    context 'ユーザーAがログインしているとき' do
      it '投稿した写真が表示される' do
        sign_in_as user_a
        visit book_path(book)

        within ".image-#{photo.id}" do
          expect have_selector 'img'
        end
      end

      it 'メモが表示される' do
        sign_in_as user_a
        visit book_path(book)

        expect(page).to have_content 'メモの内容です'
      end
    end
  end

  describe '投稿機能' do
    before do
      sign_in_as user_a
      visit new_book_photo_path(book)
    end

    context 'ファイルを選択したとき' do
      it 'プレビュー画像が表示される', js: true do
        expect(page).not_to have_selector 'img.new-img'

        expect do
          attach_file 'photo[image]', Rails.root.join('spec/factories/files/test_640x320.png')
          expect(page).to have_selector 'img.new-img'
        end.to change(book.photos, :count).by(0)
      end

      it '投稿できる' do
        expect do
          attach_file 'photo[image]', Rails.root.join('spec/factories/files/test_640x320.png')
          fill_in 'photo[note]', with: 'これはメモです'
          click_on '投稿する'
        end.to change(book.photos, :count).by(1)

        expect(page).to have_selector '.notification', text: '気になりポイントを投稿しました'
      end
    end

    context 'ファイルを選択しなかったとき' do
      it 'エラーになる' do
        expect do
          fill_in 'photo[note]', with: 'これはメモです'
          click_on '投稿する'
        end.to change(book.photos, :count).by(0)

        within '#error_explanation' do
          expect(page).to have_content '写真が選択されていません'
        end
      end
    end

    context 'メモを入力したとき' do
      it '投稿できる' do
        expect do
          attach_file 'photo[image]', Rails.root.join('spec/factories/files/test_640x320.png')
          fill_in 'photo[note]', with: 'これはメモです'
          click_on '投稿する'
        end.to change(book.photos, :count).by(1)

        expect(page).to have_selector '.notification', text: '気になりポイントを投稿しました'
        expect(page).to have_content 'これはメモです'
      end
    end

    context 'メモに140字より多い文字数を入力したとき' do
      it '投稿できない' do
        expect do
          attach_file 'photo[image]', Rails.root.join('spec/factories/files/test_640x320.png')
          fill_in 'photo[note]', with: 'a' * 141
          click_on '投稿する'
        end.to change(book.photos, :count).by(0)

        within '#error_explanation' do
          expect(page).to have_content 'メモは140文字以内で入力してください'
        end
      end
    end
  end

  describe '編集機能' do
    let!(:photo) { create(:photo, note: 'メモの編集テスト', book: book) }

    context '自分が投稿した写真のメモ' do
      it '編集できる' do
        sign_in_as user_a
        visit book_photo_path(photo.book, photo)

        expect do
          fill_in 'photo[note]', with: 'メモを編集してみた'
          click_on '更新する'

          expect(page).to have_content 'メモを更新しました'
          expect(page).to have_content 'メモを編集してみた'
        end.to change(Photo, :count).by(0)
      end
    end
  end
end
