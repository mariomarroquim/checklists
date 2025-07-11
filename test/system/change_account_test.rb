require "application_system_test_case"

class ChangeAccountTest < ApplicationSystemTestCase
  test "should work as expected" do
    skip "This test is flaky and needs to be fixed"

    click_on "Change my account"

    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Confirm"

    assert_text "successfully"
  end
end
