require "application_system_test_case"

class ChecklistsTest < ApplicationSystemTestCase
  test "visiting the initial page" do
    visit root_url
    assert_text "Checklists"
  end

  test "visiting the Rails health check page" do
    visit rails_health_check_url
    assert_text ""
  end
end
