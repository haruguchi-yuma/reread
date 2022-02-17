# frozen_string_literal: true

module SignInHelper
  def sign_in_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid,
      info: { image: user.image_url }
    )
    visit root_path
    ensure_browser_size if Capybara.current_driver == :selenium_chrome_headless

    click_on 'Googleでログイン'
    @current_user = user
  end

  def current_user
    @current_user
  end

  def ensure_browser_size(width = 1280, height = 720)
    Capybara.current_session.driver.browser.manage.window.resize_to(width, height)
  end
end
