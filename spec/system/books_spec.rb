# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :system do
  let(:user_a) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user) }

  describe '一覧表示機能' do
    let!(:book) { FactoryBot.create(:book, title: '最初の書籍', user: user_a) }

    context 'ユーザーAがログインしているとき' do
      it '登録した書籍が表示される' do
        sign_in_as user_a
        expect(page).to have_content '最初の書籍'
      end
    end

    context 'ユーザーBがログインしているとき' do
      it 'ユーザーAが登録した書籍は表示されない' do
        sign_in_as user_b
        expect(page).not_to have_content '最初の書籍'
        expect(current_path).to eq books_path
      end
    end
  end

  describe '登録機能' do
    context '書籍名を入力したとき' do
      it '登録される' do
        sign_in_as user_a
        expect do
          fill_in '書籍名', with: '最初の書籍'
          click_button '登録する'
        end.to change(user_a.books, :count).by(1)

        expect(page).to have_selector '.notification', text: '書籍を登録しました'
        expect(page).to have_content '最初の書籍'
      end
    end

    context '書籍名を入力しなかったとき' do
      it 'エラーになる' do
        sign_in_as user_a
        expect do
          fill_in '書籍名', with: ''
          click_button '登録する'
        end.to change(user_a.books, :count).by(0)

        within '#error_explanation' do
          expect(page).to have_content '書籍名を入力してください'
        end
      end
    end
  end

  describe '削除機能' do
    let(:book) { FactoryBot.create(:book, title: '最初の書籍', user: user_a) }

    context 'ユーザーAが作成したとき' do
      it '削除できる', js: true do
        sign_in_as user_a
        visit book_path(book)

        click_on 'この書籍を削除する'
        expect do
          expect(page.accept_confirm).to eq '投稿した写真も削除されます。よろしいですか？'
          expect(page).to have_content '「最初の書籍」を削除しました'
        end.to change(user_a.books, :count).by(-1)
      end

      it 'ユーザーBは削除できない' do
        sign_in_as user_b
        visit book_path(book)

        expect(page).not_to have_link 'この書籍を削除する'
        expect(current_path).to eq books_path
      end
    end
  end

  describe '編集機能' do
    let(:book) { FactoryBot.create(:book, title: '書籍名の変更', user: user_a) }

    context 'ユーザーAが作成したとき' do
      it '編集できる' do
        sign_in_as user_a
        visit edit_book_path(book)

        expect do
          fill_in '書籍名', with: '変更した書籍'
          click_button '更新する'
        end.to change(user_a.books, :count).by(0)

        expect(page).to have_selector '.notification', text: '「変更した書籍」に変更しました'
        expect(page).to have_content '変更した書籍'
      end

      it '書籍名を空文字にして更新するとエラーになる' do
        sign_in_as user_a
        visit edit_book_path(book)

        expect do
          fill_in '書籍名', with: ''
          click_button '更新する'
        end.to change(user_a.books, :count).by(0)

        within '#error_explanation' do
          expect(page).to have_content '書籍名を入力してください'
        end
      end

      it 'ユーザーBは編集できない' do
        sign_in_as user_b
        visit edit_book_path(book)

        expect(page).not_to have_button '更新する'
        expect(current_path).to eq books_path
      end
    end
  end
end
