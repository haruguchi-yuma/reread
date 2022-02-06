require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ログイン・ログアウト処理' do
    context 'ログイン処理' do
      it 'ログインできる' do
        sign_in_as user
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content '書籍の一覧'
      end

      it 'ログイン失敗'
    end

    context 'ログアウト処理' do
      it 'ログアウトできる' do
        sign_in_as user
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content 'Welcome'
      end
    end
  end
end
