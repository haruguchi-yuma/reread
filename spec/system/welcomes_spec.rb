# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome', type: :system do
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザがログインできる' do
    sign_in_as user
    expect(page).to have_content 'ログインしました'
    expect(page).to have_content '読み返したい本リスト'
  end

  it 'ログインしているユーザがログアウトできる' do
    sign_in_as user
    click_on 'ログアウト'
    expect(page).to have_content 'ログアウトしました'
    expect(page).to have_content '「また後で読み返そう」そう思って忘れてしまっている本はありませんか？'
  end

  it 'ログインしていないユーザが / ページを表示' do
    visit root_path

    expect(page).to have_content '「また後で読み返そう」そう思って忘れてしまっている本はありませんか？'
  end

  it 'ログインしているユーザが / ページを表示' do
    sign_in_as user
    visit root_path

    expect(page).to have_content '読み返したい本リスト'
  end
end
