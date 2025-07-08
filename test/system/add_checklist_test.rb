require "application_system_test_case"

class AddChecklistTest < LoggedInApplicationSystemTestCase
  test "should work as expected" do
    skip "This test is flaky and needs to be fixed"

    click_on "Add a checklist"

    fill_in "Title", with: "My new checklist"
    fill_in "Content", with: "This is the content of my new checklist."
    click_on "Confirm"

    assert_text "successfully"
  end
end
