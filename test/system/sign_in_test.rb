require "application_system_test_case"

class SignInTest < ApplicationSystemTestCase
  test "should work as expected" do
    skip "This test is flaky and needs to be fixed"

    visit root_url

    fill_in "Email address", with: user.email_address
    fill_in "Password", with: "password"
    click_on "Confirm"

    assert_text "Sign out"
  end
end
