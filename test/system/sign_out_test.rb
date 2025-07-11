require "application_system_test_case"

class SignOutTest < ApplicationSystemTestCase
  test "should work as expected" do
    skip "This test is flaky and needs to be fixed"

    click_on "Sign out"
    assert_text "Sign in"
  end
end
