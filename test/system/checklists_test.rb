require "application_system_test_case"

class ChecklistsTest < ApplicationSystemTestCase
  setup do
    @checklist = checklists(:one)
  end

  test "visiting the index" do
    visit checklists_url
    assert_selector "h1", text: "Checklists"
  end

  test "should create checklist" do
    visit checklists_url
    click_on "New checklist"

    fill_in "Content", with: @checklist.content
    fill_in "Title", with: @checklist.title
    click_on "Create Checklist"

    assert_text "Checklist was successfully created"
    click_on "Back"
  end

  test "should update Checklist" do
    visit checklist_url(@checklist)
    click_on "Edit this checklist", match: :first

    fill_in "Content", with: @checklist.content
    fill_in "Title", with: @checklist.title
    click_on "Update Checklist"

    assert_text "Checklist was successfully updated"
    click_on "Back"
  end

  test "should destroy Checklist" do
    visit checklist_url(@checklist)
    click_on "Destroy this checklist", match: :first

    assert_text "Checklist was successfully destroyed"
  end
end
