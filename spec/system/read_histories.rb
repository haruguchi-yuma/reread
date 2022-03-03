# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ReadHistories', type: :system, js: true do
  let(:book) { FactoryBot.create(:book) }

  describe '登録機能' do
    before do
      calendar_client_mock = double('Calendar client')
      allow(calendar_client_mock).to receive(:create_event)
      allow_any_instance_of(CalendarClient).to receive(:create_event).and_return(calendar_client_mock)

      sign_in_as book.user
      visit new_book_read_histories_path(book)
    end

    context 'サマリーの入力' do
      it 'デフォルトのとき登録できる' do
        expect do
          fill_in '読み返す日', with: I18n.l(Time.zone.today + 1.day, format: '00%Y-%m-%d')
          fill_in 'メモ', with: ''
          click_button 'Googleカレンダーに設定'
        end.to change(book.read_histories, :count).by(1)

        expect(page).to have_selector '.notification', text: '再読日を設定しました'
      end

      it '空白のとき登録できない' do
        expect do
          fill_in 'サマリー', with: ''
          fill_in '読み返す日', with: I18n.l(Time.zone.today + 1.day, format: '00%Y-%m-%d')
          fill_in 'メモ', with: ''
          click_button 'Googleカレンダーに設定'
        end.to change(book.read_histories, :count).by(0)

        within '#error_explanation' do
          expect(page).to have_content 'サマリーを入力してください'
        end
      end
    end

    context '日付の入力' do
      it '今日より後の日に設定したとき登録できる' do
        expect do
          fill_in '読み返す日', with: I18n.l(Time.zone.today + 1.day, format: '00%Y-%m-%d')
          fill_in 'メモ', with: ''
          click_button 'Googleカレンダーに設定'
        end.to change(book.read_histories, :count).by(1)

        expect(page).to have_selector '.notification', text: '再読日を設定しました'
      end
      it '今日または今日より前の日に設定したとき登録できない' do
        expect do
          fill_in '読み返す日', with: I18n.l(Time.zone.today - 1.day, format: '00%Y-%m-%d')
          fill_in 'メモ', with: ''
          click_button 'Googleカレンダーに設定'
        end.to change(book.read_histories, :count).by(0)

        within '#error_explanation' do
          expect(page).to have_content '読み返す日は今日より後の日付に設定してください'
        end
      end
    end
  end
end
