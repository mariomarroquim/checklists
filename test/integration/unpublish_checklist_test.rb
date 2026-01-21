require "test_helper"

class UnpublishChecklistTest < ActionDispatch::IntegrationTest
  setup(&:sign_in)

  test "should work as expected" do
    get root_url
    assert_dom "h2", "My checklists"

    delete publication_url(id: Checklist.first)

    follow_redirect!
    assert_dom "p", "Your checklist was unpublished."
  end
end
