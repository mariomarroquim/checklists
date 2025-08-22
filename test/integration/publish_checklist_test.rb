require "test_helper"

class PublishChecklistTest < ActionDispatch::IntegrationTest
  setup(&:sign_in)

  test "should work as expected" do
    get root_url
    assert_dom "h2", "My checklists"

    post publish_checklist_url(Checklist.first)

    follow_redirect!
    assert_dom "p", /Your checklist was published./
  end
end
