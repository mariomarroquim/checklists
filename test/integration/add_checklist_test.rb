require "test_helper"

class AddChecklistTest < ActionDispatch::IntegrationTest
  setup(&:sign_in)

  test "should work as expected" do
    get new_checklist_url
    assert_dom "h2", "Add a checklist"

    post checklists_url, params: {
      checklist: {
        title: "Example",
        content: "First item\nSecond item\nThird item"
      }
    }

    follow_redirect!
    assert_dom "p", "Your checklist was added."
  end
end
