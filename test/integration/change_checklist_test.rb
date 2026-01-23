require "test_helper"

class ChangeChecklistTest < ActionDispatch::IntegrationTest
  setup(&:sign_in)

  test "should work as expected" do
    get edit_checklist_url(checklist)
    assert_dom "h2", "Change checklist"

    patch checklist_url(checklist), params: {
      checklist: {
        title: "Example",
        content: "First item\nSecond item\nThird item"
      }
    }

    follow_redirect!
    assert_dom "p", "Your checklist was changed."
  end
end
