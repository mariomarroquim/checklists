require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  # Set up Capybara to mitigate flaky tests.
  Capybara.configure do |config|
    config.disable_animation = true
    config.default_max_wait_time = 8 # Seconds
  end

  protected
  def user
    @user ||= users(:one)
  end
end

# Log in an user before running system tests.
class LoggedInApplicationSystemTestCase < ApplicationSystemTestCase
  setup do
    visit root_url

    click_on "Sign out" if page.has_link?("Sign out")

    fill_in "Email address", with: user.email_address
    fill_in "Password", with: "password"
    click_on "Confirm"
  end
end
