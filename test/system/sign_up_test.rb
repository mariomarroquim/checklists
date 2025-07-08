require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test "should work as expected" do
    visit root_url
    click_on "Sign up for free!"

    fill_in "Email address", with: "test@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Confirm"

    assert_text "Sign out"
  end
end
