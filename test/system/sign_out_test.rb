require "application_system_test_case"

class SignOutTest < LoggedInApplicationSystemTestCase
  test "should work as expected" do
    click_on "Sign out"
    assert_text "Sign in"
  end
end
