# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcomes', type: :system do
  scenario 'ログインしていないユーザが / ページを表示' do
    visit root_path

    expect(page).to have_content '「また後で読み返そう」そう思って忘れてしまっている本はありませんか？'
  end
end
