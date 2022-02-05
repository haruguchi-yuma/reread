require 'rails_helper'

RSpec.describe "Welcomes", type: :system do
  scenario "ログインしていないユーザが / ページを表示" do
    visit root_path

    expect(page).to have_content "Welcome#index"
  end
end
