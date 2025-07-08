require "application_system_test_case"

class RemoveAccountTest < LoggedInApplicationSystemTestCase
  test "should work as expected" do
    click_on "Change my account"

    page.accept_alert "Are you sure?" do
      click_on "Remove my account"
    end

    assert_text "Sign in"
  end
end
