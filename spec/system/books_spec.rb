# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :system do
  let(:login_user) { create(:user) }
  let(:not_login_user) { create(:user) }

  describe '一覧表示機能' do
    let!(:book_of_login_user) { create(:book, title: 'ログインしたユーザーが登録した本', user: login_user) }
    let!(:book_of_not_login_user) { create(:book, title: 'ログインしていないユーザーが登録した本', user: not_login_user) }

    context 'ユーザーがログインしているとき' do
      it 'ログインしたユーザーが登録した書籍が表示される' do
        sign_in_as login_user
        expect(page).to have_content 'ログインしたユーザーが登録した本'
      end

      it 'ログインしていないユーザーが登録した書籍は表示されない' do
        sign_in_as login_user
        expect(page).not_to have_content 'ログインしていないユーザーが登録した本'
        expect(current_path).to eq books_path
      end
    end
  end

  describe '登録機能' do
    context 'タイトルを入力したとき' do
      it '登録される' do
        sign_in_as login_user
        click_button '読み返したい本を登録する'
        expect do
          fill_in 'book[title]', with: '最初の書籍'
          click_button '登録する'
        end.to change(login_user.books, :count).by(1)

        expect(page).to have_selector '.notification', text: '読み返したい本を登録しました'
        expect(page).to have_content '最初の書籍'
      end
    end

    context 'タイトルを入力しなかったとき' do
      it 'エラーになる' do
        sign_in_as login_user
        click_button '読み返したい本を登録する'
        expect do
          fill_in 'book[title]', with: ''
          click_button '登録する'
        end.to change(login_user.books, :count).by(0)

        click_button '読み返したい本を登録する'
        within '#error_explanation' do
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end
  end

  describe '編集機能' do
    let(:login_users_book) { create(:book, title: '書籍名の変更', user: login_user) }

    context 'ログインユーザーが作成したとき' do
      it '編集できる' do
        sign_in_as login_user
        visit edit_book_path(login_users_book)

        expect do
          fill_in 'book[title]', with: '変更した書籍'
          click_button '更新する'
        end.to change(login_user.books, :count).by(0)

        expect(page).to have_selector '.notification', text: '「変更した書籍」に変更しました'
        expect(page).to have_content '変更した書籍'
      end

      it 'タイトルを空文字にして更新するとエラーになる' do
        sign_in_as login_user
        visit edit_book_path(login_users_book)

        expect do
          fill_in 'book[title]', with: ''
          click_button '更新する'
        end.to change(login_user.books, :count).by(0)

        within '#error_explanation' do
          expect(page).to have_content 'タイトルを入力してください'
        end
      end
    end
  end

  describe '削除機能' do
    let(:login_users_book) { create(:book, title: '最初の書籍', user: login_user) }

    context '写真が一枚も投稿されていないとき' do
      it '削除できる', js: true do
        sign_in_as login_user
        visit book_path(login_users_book)

        click_on 'この書籍を削除する'
        expect do
          expect(accept_confirm).to eq '投稿した写真も削除されます。よろしいですか？'
          expect(page).to have_content '「最初の書籍」を削除しました'
        end.to change(login_user.books, :count).by(-1)
      end
    end

    context '写真が投稿されているとき' do
      let!(:photo) { create(:photo, book: login_users_book) }

      it '削除できる', js: true do
        sign_in_as login_user
        visit book_path(login_users_book)

        expect(page).to have_selector ".image-#{photo.id}"
        click_on 'この書籍を削除する'

        expect do
          expect(accept_confirm).to eq '投稿した写真も削除されます。よろしいですか？'
          expect(page).to have_content '「最初の書籍」を削除しました'
        end.to change(login_user.books, :count).by(-1)
      end
    end
  end
end
