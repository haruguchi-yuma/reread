# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Retirements', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'アカウント' do
    context 'ログインしているとき', js: true do
      it '削除できる' do
        sign_in_as user
        visit new_retirement_path

        click_on 'アカウントを削除する'
        expect do
          expect(page.accept_confirm).to eq '本当に削除しますか？'
          expect(page).to have_content 'アカウントを削除しました'
        end.to change { User.count }.by(-1)

        expect(current_path).to eq root_path
        expect(page).to have_content 'Welcome'
      end
    end

    context 'ログインしていないとき' do
      it '削除できない' do
        visit new_retirement_path

        expect(current_path).to eq root_path
        expect(page).to have_content 'Welcome'
      end
    end
  end
end