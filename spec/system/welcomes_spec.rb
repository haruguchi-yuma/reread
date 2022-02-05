require 'rails_helper'

RSpec.describe "Welcomes", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "ログインしていないユーザがwelcomeページを訪れること" do
    visit root_path

    expect(page).to have_content "Welcome#index"
  end
end
