require "application_system_test_case"

class ListChecklistsTest < LoggedInApplicationSystemTestCase
  test "should work as expected" do
    click_on "My checklists"
    assert_text "My checklists"
  end
end
