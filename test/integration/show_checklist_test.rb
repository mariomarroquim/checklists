require "test_helper"

class ShowChecklistTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get public_checklist_url(slug: Checklist.first.slug)
    assert_dom "h2", Checklist.first.title
  end
end
