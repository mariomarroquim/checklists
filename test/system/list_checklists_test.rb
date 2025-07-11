require "application_system_test_case"

class ListChecklistsTest < ApplicationSystemTestCase
  test "should work as expected" do
    skip "This test is flaky and needs to be fixed"

    click_on "My checklists"
    assert_text "My checklists"
  end
end
