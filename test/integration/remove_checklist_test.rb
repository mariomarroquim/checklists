require "test_helper"

class RemoveChecklistTest < ActionDispatch::IntegrationTest
  setup(&:sign_in)

  test "should work as expected" do
    get root_url
    assert_dom "h2", "My checklists"

    delete checklist_url(Checklist.first)

    follow_redirect!
    assert_dom "h2", "My checklists"
  end
end
